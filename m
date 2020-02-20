Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95897C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDAF24673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iH6mdeKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBTMjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:39:19 -0500
Received: from mx.treblig.org ([46.43.15.161]:58190 "EHLO mx.treblig.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgBTMjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:39:19 -0500
X-Greylist: delayed 1465 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Feb 2020 07:39:18 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=GVRZn7EnprSC0n7xsBn//SNf96r1aQPqm7cND2nX3xY=; b=iH6mdeKfFdu+fgQ4WBJZlYkIMe
        u70L6ycyavhobtFYXrVD0+dZp/JQcYsrQbFkwUgyvs1lsxvrQkhOqoG1AVFIDL4D754eUaBR/iYld
        HtI7KWCrrqiWtLr44Yd9GulkOW0dC89oNf5B+RCP+hClo8VSwJhcYdS5q8E7d3I9+nuP7N7YGCKIG
        HTvmF8XMqVqQ43SjhKWy5tmkgK5zfh4DKlfp/Tdkm7CMXB6hlePJaO8YwbYsApUv58XbccV5BPWhz
        TucI/UJnliEjcRB954hg2o6iht1TfjoMeSfbwUqE05QSbW/y1TOKI+O9I5GkHnXoTcQ7FqYhBOz2Y
        PU2bgvUg==;
Received: from dg by mx.treblig.org with local (Exim 4.92)
        (envelope-from <dg@treblig.org>)
        id 1j4kjD-0005YP-9N; Thu, 20 Feb 2020 12:14:51 +0000
Date:   Thu, 20 Feb 2020 12:14:51 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Meelis Roos <mroos@linux.ee>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: Re: w83627ehf crash in 5.6.0-rc2-00055-gca7e1fd1026c
Message-ID: <20200220121451.GA18071@gallifrey>
References: <434212bb-4eb9-7366-3255-79826d0e65bc@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434212bb-4eb9-7366-3255-79826d0e65bc@linux.ee>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/4.19.0-5-amd64 (x86_64)
X-Uptime: 12:11:25 up 172 days, 12:31,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Meelis Roos (mroos@linux.ee) wrote:
> While reading w83627ehf sensors output on D425KT mainboard, I consistently get NULL dereference as below.
> 
> 5.5.0 worked OK but gave a warning on driver load:
> [  104.514954] w83627ehf: Found W83627DHG-P chip at 0x290
> [  104.515634] w83627ehf w83627ehf.656: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> 
> This is dmesg from current git (loading the driver and reading sensors with lm-sensors - no driver loading warning any more):
> 
> [  764.718192] w83627ehf: Found W83627DHG-P chip at 0x290
> [  774.574874] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  774.574889] #PF: supervisor read access in kernel mode
> [  774.574895] #PF: error_code(0x0000) - not-present page
> [  774.574901] PGD 0 P4D 0
> [  774.574909] Oops: 0000 [#1] SMP NOPTI
> [  774.574917] CPU: 0 PID: 604 Comm: sensors Not tainted 5.6.0-rc2-00055-gca7e1fd1026c #29
> [  774.574923] Hardware name:  /D425KT, BIOS MWPNT10N.86A.0132.2013.0726.1534 07/26/2013
> [  774.574939] RIP: 0010:w83627ehf_read_string+0x27/0x70 [w83627ehf]
> [  774.574947] Code: 00 00 00 55 53 48 8d 64 24 f0 83 fa 15 48 8b 5f 78 75 29 83 fe 01 75 24 48 63 c9 48 8b 6b 58 48 83 f9 03 77 24 0f b6 44 0b 50 <48> 8b 44 c5 00 49 89 00 48 8d 64 24 10 5b 31 c0 5d c3 48 8d 64 24
> [  774.574958] RSP: 0018:ffffb95980657df8 EFLAGS: 00010293
> [  774.574965] RAX: 0000000000000000 RBX: ffff96caaa7f5218 RCX: 0000000000000000
> [  774.574972] RDX: 0000000000000015 RSI: 0000000000000001 RDI: ffff96caa736ec08
> [  774.574978] RBP: 0000000000000000 R08: ffffb95980657e20 R09: 0000000000000001
> [  774.574985] R10: ffff96caaa635cc0 R11: 0000000000000000 R12: ffff96caa9f7cf00
> [  774.574991] R13: ffff96caa9ec3d00 R14: ffff96caa9ec3d28 R15: ffff96caa9ec3d40
> [  774.574999] FS:  00007fbc7c4e2740(0000) GS:ffff96caabc00000(0000) knlGS:0000000000000000
> [  774.575008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  774.575015] CR2: 0000000000000000 CR3: 0000000129d58000 CR4: 00000000000006f0
> [  774.575021] Call Trace:
> [  774.575036]  ? cp_new_stat+0x12d/0x160
> [  774.575048]  hwmon_attr_show_string+0x37/0x70 [hwmon]

Sorry about that!
It looks like not all chips have temp_label, so I think we need to change w83627ehf_is_visible
which has:

                if (attr == hwmon_temp_input || attr == hwmon_temp_label)
                        return 0444;

to
                if (attr == hwmon_temp_input)
                        return 0444;
                if (attr == hwmon_temp_label) {
                        if (data->temp_label)
				return 0444;
			else
				return 0;
                }

Does that work for you?

Dave


> [  774.575060]  dev_attr_show+0x14/0x50
> [  774.575071]  sysfs_kf_seq_show+0xb5/0x1b0
> [  774.575081]  seq_read+0xcf/0x460
> [  774.575091]  vfs_read+0x9b/0x150
> [  774.575100]  ksys_read+0x5f/0xe0
> [  774.575111]  do_syscall_64+0x48/0x190
> [  774.575121]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  774.575130] RIP: 0033:0x7fbc7c715871
> [  774.575138] Code: fe ff ff 50 48 8d 3d 76 e5 09 00 e8 e9 ef 01 00 66 0f 1f 84 00 00 00 00 00 48 8d 05 69 3b 0d 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 48 83 ec 28 48 89 54
> [  774.575151] RSP: 002b:00007ffe5092d848 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  774.575161] RAX: ffffffffffffffda RBX: 00005630bdfb1330 RCX: 00007fbc7c715871
> [  774.575168] RDX: 0000000000001000 RSI: 00007ffe5092d8e0 RDI: 0000000000000003
> [  774.575175] RBP: 00007fbc7c7e5560 R08: 0000000000000003 R09: 00007fbc7c7e43b0
> [  774.575182] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001000
> [  774.575190] R13: 00007ffe5092d8e0 R14: 0000000000000d68 R15: 00007fbc7c7e4960
> [  774.575199] Modules linked in: w83627ehf hwmon_vid snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_pcsp snd_hda_core ir_rc6_decoder rc_rc6_mce uas r8169 mceusb snd_pcm
> iTCO_wdt rc_core snd_timer iTCO_vendor_support realtek snd libphy soundcore i2c_i801 lpc_ich parport_pc mfd_core parport coretemp hwmon autofs4
> [  774.575247] CR2: 0000000000000000
> [  774.575254] ---[ end trace 607462057ab8a988 ]---
> [  774.575264] RIP: 0010:w83627ehf_read_string+0x27/0x70 [w83627ehf]
> [  774.575273] Code: 00 00 00 55 53 48 8d 64 24 f0 83 fa 15 48 8b 5f 78 75 29 83 fe 01 75 24 48 63 c9 48 8b 6b 58 48 83 f9 03 77 24 0f b6 44 0b 50 <48> 8b 44 c5 00 49 89 00 48 8d 64 24 10 5b 31 c0 5d c3 48 8d 64 24
> [  774.575287] RSP: 0018:ffffb95980657df8 EFLAGS: 00010293
> [  774.575294] RAX: 0000000000000000 RBX: ffff96caaa7f5218 RCX: 0000000000000000
> [  774.575301] RDX: 0000000000000015 RSI: 0000000000000001 RDI: ffff96caa736ec08
> [  774.575308] RBP: 0000000000000000 R08: ffffb95980657e20 R09: 0000000000000001
> [  774.575316] R10: ffff96caaa635cc0 R11: 0000000000000000 R12: ffff96caa9f7cf00
> [  774.575323] R13: ffff96caa9ec3d00 R14: ffff96caa9ec3d28 R15: ffff96caa9ec3d40
> [  774.575331] FS:  00007fbc7c4e2740(0000) GS:ffff96caabc00000(0000) knlGS:0000000000000000
> [  774.575340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  774.575347] CR2: 0000000000000000 CR3: 0000000129d58000 CR4: 00000000000006f0
> 
> 
> -- 
> Meelis Roos <mroos@linux.ee>
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
