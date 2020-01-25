Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF630C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6948A2071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 14:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgAYNyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 08:54:08 -0500
Received: from 80-248-250-91.cust.suomicom.net ([80.248.250.91]:35030 "EHLO
        80-248-250-91.cust.suomicom.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgAYNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:54:08 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jan 2020 08:54:07 EST
Received: by smtp.eerin.fi (Postfix, from userid 1000)
        id 779D8DE0A; Sat, 25 Jan 2020 15:47:27 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
        by smtp.eerin.fi (Postfix) with ESMTP id 51BEBCBCA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 15:47:27 +0200 (EET)
Date:   Sat, 25 Jan 2020 15:47:27 +0200 (EET)
From:   Eerin Rosenstrom <eerin.rosenstrom@xylogas.fi>
To:     linux-kernel@vger.kernel.org
Subject: [4.19] clk.c cpufreq-drv odd behavior, lima/mali450 poweron suggest,
 ARM mt7623
Message-ID: <alpine.DEB.2.10.2001251423400.19316@orava>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello I'm quite new with kernel. I try to get some more Mhz's to my router 
CPU and find that cpufreq driver with clk.c behaves oddly. It fails to set 
correct Mhz but dosn't give any error returnvalues so cpufreq level thinks 
frequenzy changed correctly. Also clk.c seems to behawe something 
irrationaly when asked bigger Mhz rises..

I find also in mt7623 that Mali GPU is by default powered off and it needs 
to tweak power on register before lima module detected correctly.
Added some ioremap to lima module poweron/off GCPU when load/unload.
It is not production quality, but someone with more knowhow can maybe fix 
it more nicely shape and include it future kernels..?

And short question how to find driver/code (in mt7623) which is 
responsible to handle pm_runtime_put_sync() datastructure changes?
So where are low level drivers to handle board functions?
How they work? (I am not in kernel list please CC)

For lima init I added GCPU wakeup:
         #ifdef CONFIG_MACH_MT7623
         void __iomem *wakeup_register;
         wakeup_register = ioremap(0x10003014 , 0x04);
         writel(0x00000001,wakeup_register); // this may be wrong, may need 
bitbang 0th bit to 1
         iounmap(wakeup_register);
         #endif

There is posibility also reset GCPU:
//      wakeup_register = ioremap(0x10003000 , 0x04); // this is 
chip global reset register!!
//      writel(0x00000010,wakeup_register); // this may be wrong, may need 
bitbang 5th bit to 1
//      iounmap(wakeup_register);

And module fini I added:
         #ifdef CONFIG_MACH_MT7623
         powerdown_register = ioremap(0x1000300C , 0x04); // powerdown 
register
         writel(0x00000001,powerdown_register); // this may be wrong, may 
need bitbang 0th bit to 1
         iounmap(powerdown_register);
         #endif

There is also status register to check first GCPU current power state if 
needed:
./devmem2 0x1000301C

(GCPU status is bit 0, registers are 32bit)

More info can be found from mt7623 datatsheet (public)

lima 4.19-rc5 code have broblems/bug with error handling. It dosn't exit 
correctly when error occurs during init.
  Sometimes in 4.19 module needs to unload first and then it detecs 
correcly in 2nd load. Also if board run longer without lima module it 
can't detect it.
Only fresh boot, unload module then load put its gpu/dri detected state.
In 5.4 with more fresher lima code it detects by once with GCPU poweron 
tweak enabled.

And there is clk.c odd behavior logs:

[   17.393291] [drm:mtk_drm_crtc_atomic_enable] 
mediatek_ddp_ddp_path_setup
[   17.393361] clk: clk_set_rate asked: 864000000
[   17.393364] clk: asked clk_core_set_rate_nolock 864000000
[   17.393373] clk: round_new_rate: 863999329
[   17.393389] clk: clk_pm_runtime returned: 0
[   17.393394] clk: asked clk_change_rate, oldrate 148499848
[   17.393397] clk: clk_change_rate, new_parent bestrate 26000000
[   17.393400] clk: clk_change_rate, trace_clk_set_rate: 863999329
[   17.393427] clk: clk_change_rate, trace_clk_set_rate_complete: 
863999329
[   17.393431] clk: clk_change_rate, clk_recalc: 863999329
[   17.393433] clk: asked clk_change_rate, oldrate 148499848
[   17.393436] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393438] clk: clk_change_rate, trace_clk_set_rate: 863999329
[   17.393440] clk: clk_change_rate, trace_clk_set_rate_complete: 
863999329
[   17.393442] clk: clk_change_rate, clk_recalc: 863999329
[   17.393444] clk: asked clk_change_rate, oldrate 0
[   17.393446] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393448] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393467] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393469] clk: clk_change_rate, clk_recalc: 0
[   17.393471] clk: asked clk_change_rate, oldrate 0
[   17.393473] clk: clk_change_rate, cur_parent bestrate 0
[   17.393475] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393477] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393479] clk: clk_change_rate, clk_recalc: 0
[   17.393481] clk: asked clk_change_rate, oldrate 0
[   17.393483] clk: clk_change_rate, cur_parent bestrate 0
[   17.393485] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393487] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393489] clk: clk_change_rate, clk_recalc: 0
[   17.393491] clk: asked clk_change_rate, oldrate 0
[   17.393493] clk: clk_change_rate, cur_parent bestrate 0
[   17.393495] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393497] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393499] clk: clk_change_rate, clk_recalc: 0
[   17.393500] clk: clk_change_rate ends
[   17.393502] clk: clk_change_rate ends
[   17.393503] clk: clk_change_rate ends
[   17.393505] clk: asked clk_change_rate, oldrate 0
[   17.393507] clk: clk_change_rate, cur_parent bestrate 0
[   17.393509] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393511] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393513] clk: clk_change_rate, clk_recalc: 0
[   17.393515] clk: clk_change_rate ends
[   17.393516] clk: asked clk_change_rate, oldrate 0
[   17.393518] clk: clk_change_rate, cur_parent bestrate 0
[   17.393520] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393522] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393524] clk: clk_change_rate, clk_recalc: 0
[   17.393526] clk: clk_change_rate ends
[   17.393527] clk: clk_change_rate ends
[   17.393529] clk: clk_change_rate ends
[   17.393531] clk: asked clk_change_rate, oldrate 148499848
[   17.393533] clk: clk_change_rate, new_parent bestrate 863999329
[   17.393535] clk: clk_change_rate, trace_clk_set_rate: 863999329
[   17.393537] clk: clk_change_rate, trace_clk_set_rate_complete: 
863999329
[   17.393539] clk: clk_change_rate, clk_recalc: 863999329
[   17.393541] clk: asked clk_change_rate, oldrate 148499848
[   17.393544] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393546] clk: clk_change_rate, trace_clk_set_rate: 863999329
[   17.393548] clk: clk_change_rate, trace_clk_set_rate_complete: 
863999329
[   17.393550] clk: clk_change_rate, clk_recalc: 863999329
[   17.393552] clk: asked clk_change_rate, oldrate 148499848
[   17.393554] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393556] clk: clk_change_rate, trace_clk_set_rate: 863999329
[   17.393558] clk: clk_change_rate, trace_clk_set_rate_complete: 
863999329
[   17.393561] clk: clk_change_rate, clk_recalc: 863999329
[   17.393562] clk: clk_change_rate ends
[   17.393564] clk: asked clk_change_rate, oldrate 148499848
[   17.393566] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393568] clk: clk_change_rate, trace_clk_set_rate: 863999329
[   17.393571] clk: clk_change_rate, trace_clk_set_rate_complete: 
863999329
[   17.393573] clk: clk_change_rate, clk_recalc: 863999329
[   17.393574] clk: clk_change_rate ends
[   17.393576] clk: clk_change_rate ends
[   17.393578] clk: asked clk_change_rate, oldrate 148499848
[   17.393580] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393582] clk: clk_change_rate, trace_clk_set_rate: 863999329
[   17.393585] clk: clk_change_rate, trace_clk_set_rate_complete: 
863999329
[   17.393587] clk: clk_change_rate, clk_recalc: 863999329
[   17.393589] clk: asked clk_change_rate, oldrate 148499848
[   17.393591] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393593] clk: clk_change_rate, trace_clk_set_rate: 863999329
[   17.393595] clk: clk_change_rate, trace_clk_set_rate_complete: 
863999329
[   17.393597] clk: clk_change_rate, clk_recalc: 863999329
[   17.393599] clk: clk_change_rate ends
[   17.393601] clk: asked clk_change_rate, oldrate 148499848
[   17.393603] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393605] clk: clk_change_rate, trace_clk_set_rate: 863999329
[   17.393608] clk: clk_change_rate, trace_clk_set_rate_complete: 
863999329
[   17.393610] clk: clk_change_rate, clk_recalc: 863999329
[   17.393611] clk: clk_change_rate ends
[   17.393613] clk: clk_change_rate ends
[   17.393614] clk: clk_change_rate ends
[   17.393616] clk: asked clk_change_rate, oldrate 74249924
[   17.393618] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393621] clk: clk_change_rate, trace_clk_set_rate: 431999664
[   17.393623] clk: clk_change_rate, trace_clk_set_rate_complete: 
431999664
[   17.393625] clk: clk_change_rate, clk_recalc: 431999664
[   17.393627] clk: asked clk_change_rate, oldrate 74249924
[   17.393629] clk: clk_change_rate, cur_parent bestrate 431999664
[   17.393631] clk: clk_change_rate, trace_clk_set_rate: 431999664
[   17.393634] clk: clk_change_rate, trace_clk_set_rate_complete: 
431999664
[   17.393636] clk: clk_change_rate, clk_recalc: 431999664
[   17.393638] clk: asked clk_change_rate, oldrate 74249924
[   17.393640] clk: clk_change_rate, cur_parent bestrate 431999664
[   17.393642] clk: clk_change_rate, trace_clk_set_rate: 431999664
[   17.393644] clk: clk_change_rate, trace_clk_set_rate_complete: 
431999664
[   17.393647] clk: clk_change_rate, clk_recalc: 431999664
[   17.393648] clk: clk_change_rate ends
[   17.393650] clk: clk_change_rate ends
[   17.393651] clk: clk_change_rate ends
[   17.393653] clk: asked clk_change_rate, oldrate 37124962
[   17.393655] clk: clk_change_rate, cur_parent bestrate 863999329
[   17.393658] clk: clk_change_rate, trace_clk_set_rate: 215999832
[   17.393660] clk: clk_change_rate, trace_clk_set_rate_complete: 
215999832
[   17.393662] clk: clk_change_rate, clk_recalc: 215999832
[   17.393663] clk: clk_change_rate ends
[   17.393665] clk: clk_change_rate ends
[   17.393667] clk: changed rate to 864000000
[   17.393670] clk: clk_set_rate asked: 107999916
[   17.393673] clk: asked clk_core_set_rate_nolock 107999916
[   17.393701] clk: round_new_rate: 107999817
[   17.393710] clk: clk_pm_runtime returned: 0
[   17.393713] clk: asked clk_change_rate, oldrate 863999329
[   17.393715] clk: clk_change_rate, new_parent bestrate 26000000
[   17.393717] clk: clk_change_rate, trace_clk_set_rate: 107999817
[   17.393743] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999817
[   17.393747] clk: clk_change_rate, clk_recalc: 107999817
[   17.393749] clk: asked clk_change_rate, oldrate 863999329
[   17.393751] clk: clk_change_rate, cur_parent bestrate 107999817
[   17.393753] clk: clk_change_rate, trace_clk_set_rate: 107999817
[   17.393755] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999817
[   17.393757] clk: clk_change_rate, clk_recalc: 107999817
[   17.393759] clk: asked clk_change_rate, oldrate 0
[   17.393761] clk: clk_change_rate, cur_parent bestrate 107999817
[   17.393763] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393781] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393783] clk: clk_change_rate, clk_recalc: 0
[   17.393785] clk: asked clk_change_rate, oldrate 0
[   17.393787] clk: clk_change_rate, cur_parent bestrate 0
[   17.393789] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393791] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393793] clk: clk_change_rate, clk_recalc: 0
[   17.393795] clk: asked clk_change_rate, oldrate 0
[   17.393797] clk: clk_change_rate, cur_parent bestrate 0
[   17.393799] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393801] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393803] clk: clk_change_rate, clk_recalc: 0
[   17.393805] clk: asked clk_change_rate, oldrate 0
[   17.393806] clk: clk_change_rate, cur_parent bestrate 0
[   17.393808] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393810] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393812] clk: clk_change_rate, clk_recalc: 0
[   17.393814] clk: clk_change_rate ends
[   17.393815] clk: clk_change_rate ends
[   17.393817] clk: clk_change_rate ends
[   17.393819] clk: asked clk_change_rate, oldrate 0
[   17.393821] clk: clk_change_rate, cur_parent bestrate 0
[   17.393823] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393825] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393826] clk: clk_change_rate, clk_recalc: 0
[   17.393828] clk: clk_change_rate ends
[   17.393830] clk: asked clk_change_rate, oldrate 0
[   17.393832] clk: clk_change_rate, cur_parent bestrate 0
[   17.393834] clk: clk_change_rate, trace_clk_set_rate: 0
[   17.393836] clk: clk_change_rate, trace_clk_set_rate_complete: 0
[   17.393838] clk: clk_change_rate, clk_recalc: 0
[   17.393839] clk: clk_change_rate ends
[   17.393841] clk: clk_change_rate ends
[   17.393842] clk: clk_change_rate ends
[   17.393844] clk: asked clk_change_rate, oldrate 863999329
[   17.393847] clk: clk_change_rate, new_parent bestrate 107999817
[   17.393849] clk: clk_change_rate, trace_clk_set_rate: 107999817
[   17.393851] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999817
[   17.393853] clk: clk_change_rate, clk_recalc: 107999817
[   17.393855] clk: asked clk_change_rate, oldrate 863999329
[   17.393857] clk: clk_change_rate, new_parent bestrate 107999817
[   17.393859] clk: clk_change_rate, trace_clk_set_rate: 107999817
[   17.393861] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999817
[   17.393864] clk: clk_change_rate, clk_recalc: 107999817
[   17.393866] clk: asked clk_change_rate, oldrate 863999329
[   17.393868] clk: clk_change_rate, cur_parent bestrate 107999817
[   17.393870] clk: clk_change_rate, trace_clk_set_rate: 107999817
[   17.393872] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999817
[   17.393874] clk: clk_change_rate, clk_recalc: 107999817
[   17.393876] clk: clk_change_rate ends
[   17.393878] clk: asked clk_change_rate, oldrate 863999329
[   17.393880] clk: clk_change_rate, new_parent bestrate 107999817
[   17.393882] clk: clk_change_rate, trace_clk_set_rate: 107999817
[   17.393884] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999817
[   17.393887] clk: clk_change_rate, clk_recalc: 107999817
[   17.393888] clk: clk_change_rate ends
[   17.393890] clk: clk_change_rate ends
[   17.393892] clk: asked clk_change_rate, oldrate 863999329
[   17.393894] clk: clk_change_rate, cur_parent bestrate 107999817
[   17.393896] clk: clk_change_rate, trace_clk_set_rate: 107999817
[   17.393898] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999817
[   17.393900] clk: clk_change_rate, clk_recalc: 107999817
[   17.393902] clk: asked clk_change_rate, oldrate 863999329
[   17.393904] clk: clk_change_rate, cur_parent bestrate 107999817
[   17.393907] clk: clk_change_rate, trace_clk_set_rate: 107999817
[   17.393909] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999817
[   17.393911] clk: clk_change_rate, clk_recalc: 107999817
[   17.393912] clk: clk_change_rate ends
[   17.393915] clk: asked clk_change_rate, oldrate 863999329
[   17.393917] clk: clk_change_rate, cur_parent bestrate 107999817
[   17.393919] clk: clk_change_rate, trace_clk_set_rate: 107999817
[   17.393921] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999817
[   17.393923] clk: clk_change_rate, clk_recalc: 107999817
[   17.393925] clk: clk_change_rate ends
[   17.393926] clk: clk_change_rate ends
[   17.393928] clk: clk_change_rate ends
[   17.393930] clk: asked clk_change_rate, oldrate 431999664
[   17.393932] clk: clk_change_rate, cur_parent bestrate 107999817
[   17.393934] clk: clk_change_rate, trace_clk_set_rate: 53999908
[   17.393936] clk: clk_change_rate, trace_clk_set_rate_complete: 53999908
[   17.393938] clk: clk_change_rate, clk_recalc: 53999908
[   17.393940] clk: asked clk_change_rate, oldrate 431999664
[   17.393942] clk: clk_change_rate, cur_parent bestrate 53999908
[   17.393944] clk: clk_change_rate, trace_clk_set_rate: 53999908
[   17.393946] clk: clk_change_rate, trace_clk_set_rate_complete: 53999908
[   17.393948] clk: clk_change_rate, clk_recalc: 53999908
[   17.393951] clk: asked clk_change_rate, oldrate 431999664
[   17.393953] clk: clk_change_rate, cur_parent bestrate 53999908
[   17.393955] clk: clk_change_rate, trace_clk_set_rate: 53999908
[   17.393957] clk: clk_change_rate, trace_clk_set_rate_complete: 53999908
[   17.393959] clk: clk_change_rate, clk_recalc: 53999908
[   17.393960] clk: clk_change_rate ends
[   17.393962] clk: clk_change_rate ends
[   17.393963] clk: clk_change_rate ends
[   17.393965] clk: asked clk_change_rate, oldrate 215999832
[   17.393968] clk: clk_change_rate, cur_parent bestrate 107999817
[   17.393970] clk: clk_change_rate, trace_clk_set_rate: 26999954
[   17.393972] clk: clk_change_rate, trace_clk_set_rate_complete: 26999954
[   17.393974] clk: clk_change_rate, clk_recalc: 26999954
[   17.393975] clk: clk_change_rate ends
[   17.393977] clk: clk_change_rate ends
[   17.393979] clk: changed rate to 107999916
[   17.398042] clk: clk_set_rate asked: 108000000
[   17.398046] clk: asked clk_core_set_rate_nolock 108000000
[   17.398059] clk: round_new_rate: 108000000
[   17.398071] clk: clk_pm_runtime returned: 0
[   17.398075] clk: asked clk_change_rate, oldrate 107999817
[   17.398077] clk: clk_change_rate, new_parent bestrate 26000000
[   17.398079] clk: clk_change_rate, trace_clk_set_rate: 107999917
[   17.398106] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999917
[   17.398109] clk: clk_change_rate, clk_recalc: 107999917
[   17.398112] clk: asked clk_change_rate, oldrate 107999817
[   17.398114] clk: clk_change_rate, new_parent bestrate 107999917
[   17.398116] clk: clk_change_rate, trace_clk_set_rate: 107999917
[   17.398118] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999917
[   17.398120] clk: clk_change_rate, clk_recalc: 107999917
[   17.398122] clk: asked clk_change_rate, oldrate 0
[   17.398124] clk: clk_change_rate, new_parent bestrate 107999917
[   17.398126] clk: clk_change_rate, trace_clk_set_rate: 108000000
[   17.398145] clk: clk_change_rate, trace_clk_set_rate_complete: 
108000000
[   17.398147] clk: clk_change_rate, clk_recalc: 108000000
[   17.398149] clk: asked clk_change_rate, oldrate 0
[   17.398151] clk: clk_change_rate, new_parent bestrate 108000000
[   17.398154] clk: clk_change_rate, trace_clk_set_rate: 108000000
[   17.398156] clk: clk_change_rate, trace_clk_set_rate_complete: 
108000000
[   17.398158] clk: clk_change_rate, clk_recalc: 108000000
[   17.398160] clk: asked clk_change_rate, oldrate 0
[   17.398162] clk: clk_change_rate, new_parent bestrate 108000000
[   17.398164] clk: clk_change_rate, trace_clk_set_rate: 108000000
[   17.398166] clk: clk_change_rate, trace_clk_set_rate_complete: 
108000000
[   17.398169] clk: clk_change_rate, clk_recalc: 108000000
[   17.398170] clk: asked clk_change_rate, oldrate 0
[   17.398173] clk: clk_change_rate, new_parent bestrate 108000000
[   17.398175] clk: clk_change_rate, trace_clk_set_rate: 108000000
[   17.398177] clk: clk_change_rate, trace_clk_set_rate_complete: 
108000000
[   17.398179] clk: clk_change_rate, clk_recalc: 108000000
[   17.398181] clk: clk_change_rate ends
[   17.398182] clk: clk_change_rate ends
[   17.398184] clk: clk_change_rate ends
[   17.398186] clk: asked clk_change_rate, oldrate 0
[   17.398188] clk: clk_change_rate, cur_parent bestrate 108000000
[   17.398190] clk: clk_change_rate, trace_clk_set_rate: 54000000
[   17.398192] clk: clk_change_rate, trace_clk_set_rate_complete: 54000000
[   17.398194] clk: clk_change_rate, clk_recalc: 54000000
[   17.398195] clk: clk_change_rate ends
[   17.398197] clk: asked clk_change_rate, oldrate 0
[   17.398199] clk: clk_change_rate, cur_parent bestrate 108000000
[   17.398201] clk: clk_change_rate, trace_clk_set_rate: 36000000
[   17.398204] clk: clk_change_rate, trace_clk_set_rate_complete: 36000000
[   17.398206] clk: clk_change_rate, clk_recalc: 36000000
[   17.398207] clk: clk_change_rate ends
[   17.398209] clk: clk_change_rate ends
[   17.398210] clk: clk_change_rate ends
[   17.398213] clk: asked clk_change_rate, oldrate 107999817
[   17.398215] clk: clk_change_rate, cur_parent bestrate 107999917
[   17.398217] clk: clk_change_rate, trace_clk_set_rate: 107999917
[   17.398219] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999917
[   17.398221] clk: clk_change_rate, clk_recalc: 107999917
[   17.398223] clk: asked clk_change_rate, oldrate 107999817
[   17.398225] clk: clk_change_rate, cur_parent bestrate 107999917
[   17.398227] clk: clk_change_rate, trace_clk_set_rate: 107999917
[   17.398230] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999917
[   17.398232] clk: clk_change_rate, clk_recalc: 107999917
[   17.398234] clk: asked clk_change_rate, oldrate 107999817
[   17.398236] clk: clk_change_rate, cur_parent bestrate 107999917
[   17.398238] clk: clk_change_rate, trace_clk_set_rate: 107999917
[   17.398241] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999917
[   17.398243] clk: clk_change_rate, clk_recalc: 107999917
[   17.398244] clk: clk_change_rate ends
[   17.398246] clk: asked clk_change_rate, oldrate 107999817
[   17.398249] clk: clk_change_rate, cur_parent bestrate 107999917
[   17.398251] clk: clk_change_rate, trace_clk_set_rate: 107999917
[   17.398253] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999917
[   17.398255] clk: clk_change_rate, clk_recalc: 107999917
[   17.398256] clk: clk_change_rate ends
[   17.398258] clk: clk_change_rate ends
[   17.398260] clk: asked clk_change_rate, oldrate 107999817
[   17.398262] clk: clk_change_rate, cur_parent bestrate 107999917
[   17.398264] clk: clk_change_rate, trace_clk_set_rate: 107999917
[   17.398267] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999917
[   17.398269] clk: clk_change_rate, clk_recalc: 107999917
[   17.398271] clk: asked clk_change_rate, oldrate 107999817
[   17.398273] clk: clk_change_rate, cur_parent bestrate 107999917
[   17.398275] clk: clk_change_rate, trace_clk_set_rate: 107999917
[   17.398278] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999917
[   17.398280] clk: clk_change_rate, clk_recalc: 107999917
[   17.398281] clk: clk_change_rate ends
[   17.398283] clk: asked clk_change_rate, oldrate 107999817
[   17.398285] clk: clk_change_rate, cur_parent bestrate 107999917
[   17.398287] clk: clk_change_rate, trace_clk_set_rate: 107999917
[   17.398290] clk: clk_change_rate, trace_clk_set_rate_complete: 
107999917
[   17.398292] clk: clk_change_rate, clk_recalc: 107999917
[   17.398293] clk: clk_change_rate ends
[   17.398295] clk: clk_change_rate ends
[   17.398296] clk: clk_change_rate ends
[   17.398298] clk: asked clk_change_rate, oldrate 53999908
[   17.398301] clk: clk_change_rate, cur_parent bestrate 107999917
[   17.398303] clk: clk_change_rate, trace_clk_set_rate: 53999958
[   17.398305] clk: clk_change_rate, trace_clk_set_rate_complete: 53999958
[   17.398307] clk: clk_change_rate, clk_recalc: 53999958
[   17.398309] clk: asked clk_change_rate, oldrate 53999908
[   17.398311] clk: clk_change_rate, cur_parent bestrate 53999958
[   17.398313] clk: clk_change_rate, trace_clk_set_rate: 53999958
[   17.398315] clk: clk_change_rate, trace_clk_set_rate_complete: 53999958
[   17.398317] clk: clk_change_rate, clk_recalc: 53999958
[   17.398319] clk: asked clk_change_rate, oldrate 53999908
[   17.398321] clk: clk_change_rate, cur_parent bestrate 53999958
[   17.398323] clk: clk_change_rate, trace_clk_set_rate: 53999958
[   17.398325] clk: clk_change_rate, trace_clk_set_rate_complete: 53999958
[   17.398327] clk: clk_change_rate, clk_recalc: 53999958
[   17.398328] clk: clk_change_rate ends
[   17.398330] clk: clk_change_rate ends
[   17.398331] clk: clk_change_rate ends
[   17.398333] clk: asked clk_change_rate, oldrate 26999954
[   17.398336] clk: clk_change_rate, cur_parent bestrate 107999917
[   17.398338] clk: clk_change_rate, trace_clk_set_rate: 26999979
[   17.398340] clk: clk_change_rate, trace_clk_set_rate_complete: 26999979
[   17.398342] clk: clk_change_rate, clk_recalc: 26999979
[   17.398343] clk: clk_change_rate ends
[   17.398345] clk: clk_change_rate ends
[   17.398347] clk: changed rate to 108000000

And successfull CPU Mhz change log to 1.3Ghz:

[    5.456433] cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 
1040000 KHz
[    5.463803] cpufreq: notification 0 of frequency transition to 1300000 
kHz
[    5.470655] cpufreqdrv: set_target oldwas: hz:1040000000 vproc:1150000
[    5.477159] cpufreqdrv: set_target newis: hz:1300000000 vproc:1138500
[    5.483567] cpufreqdrv: set_target targetVis: 1138500
[    5.488583] cpufreqdrv: set_target skipped vprocset because 
target_vproc:1138500
[    5.495941] clk: asked clk_set_parent
[    5.499663] clk: asked clk_core_set_parent_nolock
[    5.504475] clk: clk_core_set_parent_nolock p_rate: 1092000000
[    5.510354] clk: clk_core_set_parent_nolock speculate_rates ret: 0
[    5.516604] clk: clk_core_set_parent_nolock set_parent ret: 0
[    5.522396] clk: clk_core_set_parent_nolock ends
[    5.527078] clk: clk_set_parent clk_core_set_parent_nolock ret: 0
[    5.533227] cpufreqdrv: clk_set_parent return: 0
[    5.537809] clk: clk_set_rate asked: 1300000000
[    5.542391] clk: asked clk_core_set_rate_nolock 1300000000
[    5.547956] clk: round_new_rate: 1300000000
[    5.552204] clk: clk_pm_runtime returned: 0
[    5.556379] clk: asked clk_change_rate, oldrate 1040000000
[    5.561825] clk: clk_change_rate, new_parent bestrate 26000000
[    5.567631] clk: clk_change_rate, trace_clk_set_rate: 1300000000
[    5.573633] clk: clk_change_rate, trace_clk_set_rate_complete: 
1300000000
[    5.580374] clk: clk_change_rate, clk_recalc: 1300000000
[    5.585658] clk: asked clk_change_rate, oldrate 1040000000
[    5.591103] clk: clk_change_rate, cur_parent bestrate 1300000000
[    5.597079] clk: clk_change_rate, trace_clk_set_rate: 1300000000
[    5.603054] clk: clk_change_rate, trace_clk_set_rate_complete: 
1300000000
[    5.609792] clk: clk_change_rate, clk_recalc: 1300000000
[    5.615085] clk: clk_change_rate ends
[    5.618719] clk: clk_change_rate ends
[    5.622352] clk: changed rate to 1300000000
[    5.626605] cpufreqdrv: clk_set_rate 1300000000 return: 0
[    5.631964] clk: asked clk_set_parent
[    5.635701] clk: asked clk_core_set_parent_nolock
[    5.640457] clk: clk_core_set_parent_nolock p_rate: 1300000000
[    5.646345] clk: clk_core_set_parent_nolock speculate_rates ret: 0
[    5.652575] clk: clk_core_set_parent_nolock set_parent ret: 0
[    5.658376] clk: clk_core_set_parent_nolock ends
[    5.663052] clk: clk_set_parent clk_core_set_parent_nolock ret: 0
[    5.669184] cpufreqdrv: clk_set_parent return: 0
[    5.673775] cpufreqdrv: set_vproc: 1138500
[    5.677838] reg-core: asked: regulator_set_voltage min:1138500 
max:1148500
[    5.684703] cpufreqdrv: finished function
[    5.688683] cpufreq: notification 1 of frequency transition to 1300000 
kHz
[    5.695530] cpufreq: cpufreq_online: CPU0: Unlisted initial frequency 
changed to: 1300000 KHz
[    5.702928] usb 3-1: new low-speed USB device number 2 using xhci-mtk
[    5.704067] cpufreqdev: asked mtk_cpufreq_ready


And unsuccesfull change to 1.4Ghz:

[   34.212222] cpufreq: notification 0 of frequency transition to 1399999 
kHz
[   34.212256] cpufreqdrv: set_target oldwas: hz:1300000000 vproc:1143750
[   34.212267] cpufreqdrv: set_target newis: hz:1399999390 vproc:1150000
[   34.212269] cpufreqdrv: set_target targetVis: 1150000
[   34.212272] cpufreqdrv: set_vproc: 1150000
[   34.212276] reg-core: asked: regulator_set_voltage min:1150000 
max:1160000
[   34.212308] clk: asked clk_set_parent
[   34.212311] clk: asked clk_core_set_parent_nolock
[   34.212316] clk: clk_core_set_parent_nolock p_rate: 1092000000
[   34.212321] clk: clk_core_set_parent_nolock speculate_rates ret: 0
[   34.212332] clk: clk_core_set_parent_nolock set_parent ret: 0
[   34.212335] clk: clk_core_set_parent_nolock ends
[   34.212338] clk: clk_set_parent clk_core_set_parent_nolock ret: 0
[   34.212342] cpufreqdrv: clk_set_parent return: 0
[   34.212345] clk: clk_set_rate asked: 1399999390
[   34.212349] clk: asked clk_core_set_rate_nolock 1399999390
[   34.212358] clk: round_new_rate: 1399999390
[   34.212364] clk: clk_pm_runtime returned: 0
[   34.212369] clk: asked clk_change_rate, oldrate 1300000000
[   34.212372] clk: clk_change_rate, new_parent bestrate 26000000
[   34.212377] clk: clk_change_rate, trace_clk_set_rate: 1399999390
[   34.212405] clk: clk_change_rate, trace_clk_set_rate_complete: 
1399999390
[   34.212410] clk: clk_change_rate, clk_recalc: 1300000000
[   34.212414] clk: asked clk_change_rate, oldrate 1300000000
[   34.212417] clk: clk_change_rate, cur_parent bestrate 1300000000
[   34.212420] clk: clk_change_rate, trace_clk_set_rate: 1399999390
[   34.212423] clk: clk_change_rate, trace_clk_set_rate_complete: 
1399999390
[   34.212426] clk: clk_change_rate, clk_recalc: 1300000000
[   34.212429] clk: clk_change_rate ends
[   34.212431] clk: clk_change_rate ends
[   34.212435] clk: changed rate to 1399999390
[   34.212439] cpufreqdrv: clk_set_rate 1399999390 return: 0
[   34.212441] clk: asked clk_set_parent
[   34.212444] clk: asked clk_core_set_parent_nolock
[   34.212447] clk: clk_core_set_parent_nolock p_rate: 1300000000
[   34.212450] clk: clk_core_set_parent_nolock speculate_rates ret: 0
[   34.212456] clk: clk_core_set_parent_nolock set_parent ret: 0
[   34.212458] clk: clk_core_set_parent_nolock ends
[   34.212461] clk: clk_set_parent clk_core_set_parent_nolock ret: 0
[   34.212463] cpufreqdrv: clk_set_parent return: 0
[   34.212466] cpufreqdrv: finished function
[   34.212470] cpufreq: notification 1 of frequency transition to 1399999 
kHz

Thank you for reading
