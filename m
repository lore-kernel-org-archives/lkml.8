Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAB2C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE76217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgEIChl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 22:37:41 -0400
Received: from mail-dm6nam11olkn2084.outbound.protection.outlook.com ([40.92.19.84]:17632
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbgEIChj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:37:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qop7r4dDOgYUVmTbJwII6DdtftSorhFFuiMqC0sfTpxJTrjiv9V8GmbEdOpmNpgxOUhi1SrSI1h9kB5AmvHnNtcIOFIPGUbA71fbFo9keqTDfLBpCb62LJtwY+mp84XPSN/OQarnvBrK3MG1PneIqnGjWDEOgMSkXWS2scGh/nw3gxY5obEDQ2Chbk+Zr16+u7mfIB6y0RHB/KFT2/7O4+yzqZa9fLa82UZc+YAuk/37JCOL1WI73yMZ7AfVhUpn6kuWPgySXGIYOgkTyj96Z72+atlEvf4A+4k+Cljhc5jQLBBk+vhaVvtwZvgGi6/LwVibRpwMeYPwrtlWbz0NCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miA1couZQiucnkU9saWAEWwpHCl0lTsdVbGlpqLLT7w=;
 b=oNkc9oqvv0jK/I03bDK0yKKDmpxbBxdldep7Loanb5xz2qYSRHJbwGA901eWcbIcAcbJNMEsbYALymqLttn48dSCe2HmnGTLw4ICRd+ttVcZcjki2SzQY1sTd7tOJrK6ui+IPXuusWLEAhjSIuZM3TZyqSnw+cx+MJzAjah2fiJQfx2d2bNkvsYC40aNe6Sj5+VHR7AXEcMqNG7lSnenBAHbs1dhKnYKBMTPKiws+NrTToyDLf2gnJis2K/63Ycf5vm18nO+6MTfQ+g12jF7Pv8pxRfgkRaAO4FUaQuFQ7GomSPclKQpV8qIaDkP/wmYWn0U0sUwpb+Un0R9aN+Thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::44) by
 CO1NAM11HT021.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::265)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Sat, 9 May
 2020 02:37:35 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::45) by CO1NAM11FT009.mail.protection.outlook.com
 (2a01:111:e400:3861::317) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Sat, 9 May 2020 02:37:35 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:34C15B2C35B2784D102B3EBF50D381EA374E3F55A6B6407F86147F5EF2BE5EC0;UpperCasedChecksum:867142346C9EE753EF98CF937DBFD7593B66403849989B4AF008794EE37C9658;SizeAsReceived:9134;Count:49
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.033; Sat, 9 May 2020
 02:37:35 +0000
Subject: Re: [PATCH] phy: samsung: s5pv210-usb2: Add delay after reset
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, s.nawrocki@samsung.com,
        kamil@wypas.org, krzk@kernel.org, linux-samsung-soc@vger.kernel.org
References: <BN6PR04MB06605D52502816E500683553A3D10@BN6PR04MB0660.namprd04.prod.outlook.com>
 <979ae7cd-2648-c516-1465-3a1507d5fefb@ti.com>
 <f8e8aa73-15bb-9bbd-d983-cba12528ba01@live.ca>
Message-ID: <BN6PR04MB0660BFD80EEDC022EB1EA757A3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Fri, 8 May 2020 19:37:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <f8e8aa73-15bb-9bbd-d983-cba12528ba01@live.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0054.namprd22.prod.outlook.com
 (2603:10b6:300:12a::16) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <687ff76a-a233-684e-9ebe-2cf7742cbcd8@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0054.namprd22.prod.outlook.com (2603:10b6:300:12a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29 via Frontend Transport; Sat, 9 May 2020 02:37:34 +0000
X-Microsoft-Original-Message-ID: <687ff76a-a233-684e-9ebe-2cf7742cbcd8@live.ca>
X-TMN:  [lCnU9cw9uxs/00hb6ME6Db5e5nyzfPJ15l+zpPVH6KRXoUjK397EOucr1UEGgF+v]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 8498a09c-4b45-4d22-302d-08d7f3c1ee89
X-MS-TrafficTypeDiagnostic: CO1NAM11HT021:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwnZWGp9rcI4xfhriWZMhu9yGASKwzVWLtSJ5Mlbu6Fp5zrQcwXYTAyZF93OYmVG7U3fB79EBuJJpytmNBQwH+AXyK/THehe0lO4mVQaGhoIeoB/SfTKT0GK70wBqvx5Bo2aVOwdDXA559d0xXBCg/3m+hs/QRlFBXTpIzWCnnKyciBpaLHzEqdqr4rQTcDXtJ2HCGjabMOgKkLwrHenVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: ATCYN7Z7OfaPh+tmGMWeUOTug3utPZ7Q6MElwpS0Hm2Q1kllQVcBiGv0cIfIOx0Jb1FlrrXqUO7B02+d+XK2AmBnnNYNaSYl6A4YzKSpg48wNzda6pOkMQsdpFHG1OsycO19Ibuosx5340C7UlYGdXFc93M7t8TYv5mnx6Mbf8lWYoLnWbd6GJ3zSYgf4O10Blxqz+0V7jsHqAUqK9AoxA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8498a09c-4b45-4d22-302d-08d7f3c1ee89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2020 02:37:35.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Is there anything else you (or someone else) needs from me?  I'd really appreciate getting USB working again on s5pv210 as without this patch it is entirely broken.

Thanks,
Jonathan

On 2020-04-28 2:50 p.m., Jonathan Bakker wrote:
> Hi Kishon,
> 
> On 2020-04-27 5:40 a.m., Kishon Vijay Abraham I wrote:
>> Hi Jonathan,
>>
>> On 4/25/2020 11:06 PM, Jonathan Bakker wrote:
>>> The USB phy takes some time to reset, so make sure we give it to it. The
>>> delay length was taken from the 4x12 phy driver.
>>>
>>> This manifested in issues with the DWC2 driver since commit fe369e1826b3
>>> ("usb: dwc2: Make dwc2_readl/writel functions endianness-agnostic.")
>>> where the endianness check would read the DWC ID as 0 due to the phy still
>>> resetting, resulting in the wrong endian mode being chosen.
>>>
>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>> ---
>>>  drivers/phy/samsung/phy-s5pv210-usb2.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/phy/samsung/phy-s5pv210-usb2.c b/drivers/phy/samsung/phy-s5pv210-usb2.c
>>> index 56a5083fe6f9..32be62e49804 100644
>>> --- a/drivers/phy/samsung/phy-s5pv210-usb2.c
>>> +++ b/drivers/phy/samsung/phy-s5pv210-usb2.c
>>> @@ -139,6 +139,10 @@ static void s5pv210_phy_pwr(struct samsung_usb2_phy_instance *inst, bool on)
>>>  		udelay(10);
>>>  		rst &= ~rstbits;
>>>  		writel(rst, drv->reg_phy + S5PV210_UPHYRST);
>>> +		/* The following delay is necessary for the reset sequence to be
>>> +		 * completed
>>> +		 */
>>> +		udelay(80);
>>
>> Please fix the following checkpatch check error.
>> CHECK: usleep_range is preferred over udelay; see
>> Documentation/timers/timers-howto.rst
>> #151: FILE: drivers/phy/samsung/phy-s5pv210-usb2.c:145:
>> +               udelay(80);
>>
>> total: 0 errors, 0 warnings, 1 checks, 10 lines checked
> 
> 
> Unfortunately, this is an atomic code path (and hence why the other Samsung phy driver use udelay
> in the same place). Changing to usleep_range brings up the following BUG:
> 
> BUG: scheduling while atomic: swapper/1/0x00000002
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.7.0-rc2-00001-gf9f8ac7cc48c-dirty #443
> Hardware name: Samsung S5PC110/S5PV210-based board
> [<c010c744>] (unwind_backtrace) from [<c010a114>] (show_stack+0x10/0x14)
> [<c010a114>] (show_stack) from [<c0139f24>] (__schedule_bug+0x70/0x84)
> [<c0139f24>] (__schedule_bug) from [<c073acc4>] (__schedule+0x38c/0x464)
> [<c073acc4>] (__schedule) from [<c073ae3c>] (schedule+0xa0/0x138)
> [<c073ae3c>] (schedule) from [<c073ee9c>] (schedule_hrtimeout_range_clock+0xd4/0x158)
> [<c073ee9c>] (schedule_hrtimeout_range_clock) from [<c073ef38>] (schedule_hrtimeout_range+0x18/0x20)
> [<c073ef38>] (schedule_hrtimeout_range) from [<c073e84c>] (usleep_range+0x68/0x8c)
> [<c073e84c>] (usleep_range) from [<c03e2e50>] (s5pv210_power_on+0xbc/0xe4)
> [<c03e2e50>] (s5pv210_power_on) from [<c03e2bf0>] (samsung_usb2_phy_power_on+0xec/0x16c)
> [<c03e2bf0>] (samsung_usb2_phy_power_on) from [<c03e1e14>] (phy_power_on+0x8c/0xdc)
> [<c03e1e14>] (phy_power_on) from [<c053ab4c>] (__dwc2_lowlevel_hw_enable+0xb8/0xcc)
> [<c053ab4c>] (__dwc2_lowlevel_hw_enable) from [<c053ae80>] (dwc2_driver_probe+0x1e4/0x580)
> [<c053ae80>] (dwc2_driver_probe) from [<c04b0e9c>] (platform_drv_probe+0x48/0x98)
> [<c04b0e9c>] (platform_drv_probe) from [<c04af098>] (really_probe+0x1e0/0x344)
> [<c04af098>] (really_probe) from [<c04af338>] (driver_probe_device+0x60/0x168)
> [<c04af338>] (driver_probe_device) from [<c04af5e0>] (device_driver_attach+0x58/0x60)
> [<c04af5e0>] (device_driver_attach) from [<c04af640>] (__driver_attach+0x58/0xcc)
> [<c04af640>] (__driver_attach) from [<c04ad348>] (bus_for_each_dev+0x74/0xb4)
> [<c04ad348>] (bus_for_each_dev) from [<c04ae510>] (bus_add_driver+0x1b4/0x1d4)
> [<c04ae510>] (bus_add_driver) from [<c04afee0>] (driver_register+0x74/0x108)
> [<c04afee0>] (driver_register) from [<c0101710>] (do_one_initcall+0x7c/0x1cc)
> [<c0101710>] (do_one_initcall) from [<c0a00ed8>] (kernel_init_freeable+0x15c/0x1d4)
> [<c0a00ed8>] (kernel_init_freeable) from [<c073a398>] (kernel_init+0x8/0x110)
> [<c073a398>] (kernel_init) from [<c0100148>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xe745ffb0 to 0xe745fff8)
> ffa0:                                     00000000 00000000 00000000 00000000
> ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
> dwc2 ec000000.hsotg: dwc2_check_params: Invalid parameter besl=1
> dwc2 ec000000.hsotg: dwc2_check_params: Invalid parameter g_np_tx_fifo_size=1024
> dwc2 ec000000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
> ------------[ cut here ]------------
> kernel BUG at mm/vmalloc.c:2101!
> Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.7.0-rc2-00001-gf9f8ac7cc48c-dirty #443
> Hardware name: Samsung S5PC110/S5PV210-based board
> PC is at __get_vm_area_node+0x174/0x178
> LR is at 0xe745e000
> pc : [<c01cf678>]    lr : [<e745e000>]    psr: 20000013
> sp : e745fc60  ip : 001fff00  fp : 00000038
> r10: e6cb9880  r9 : 00000001  r8 : c0161760
> r7 : e6cb98c0  r6 : 00000cc0  r5 : 00000247  r4 : e7fd2800
> r3 : e8800000  r2 : 00000010  r1 : ffffffff  r0 : 00001000
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 30004019  DAC: 00000051
> Process swapper (pid: 1, stack limit = 0x(ptrval))
> Stack: (0xe745fc60 to 0xe7460000)
> fc60: ffffe000 c014d04c c09082c0 e7fd2800 00000247 e6cb98c0 e6cb98c0 c0161760
> fc80: 00000000 c01cf788 ff800000 ffffffff 00000cc0 c0161760 e7fd2800 c0162be4
> fca0: e7fd2800 00001000 00000247 c0162cd4 00000001 e7fd2800 00001000 00000247
> fcc0: ffffffff c010e384 e757c810 c0b03008 00000cc0 e76f3c48 ffffffff c010e3e4
> fce0: e745fd04 c0161760 00000001 e76f3c48 ffffffff c010e510 e7401c00 00000000
> fd00: c0166698 00000000 e757c810 00001000 00000cc0 00000247 c0161760 00000001
> fd20: 00000000 57579938 ffffe000 00000000 c0b03008 e757c810 00000008 00000cc0
> fd40: 00000000 e76f3c48 c0a27830 c010e6a8 00000247 00000000 00000000 c0161760
> fd60: c010e668 c0161760 00000000 c01e7e94 e76f3840 57579938 e6cbd1c0 00000cc0
> fd80: 00000000 00000008 e757c810 e76f3c48 00000000 c016182c 00000000 00000010
> fda0: e6cbd100 e76f3840 00000000 00000000 00000010 e757c810 c0b20994 c054176c
> fdc0: 00000000 00000000 c0b03008 e757c800 00000000 c0b03008 e757c800 e757c810
> fde0: e76f3840 c053afb0 00000080 e757a640 e76f3840 57579938 e757a600 57579938
> fe00: e757c810 e757c810 00000000 c0b20994 00000000 00000000 c0b20994 c04b0e9c
> fe20: c0b685f8 e757c810 c0b685fc 00000000 00000000 c04af098 e757c810 c0b20994
> fe40: c0b20994 c04af5e8 00000000 000000a9 c0a27850 c04af338 c0a27850 c05d8e30
> fe60: a0000013 e757c810 00000000 c0b20994 c04af5e8 00000000 000000a9 c0a27850
> fe80: c0a27830 c04af5e0 00000000 c0b20994 e757c810 c04af640 e75705b0 c0b03008
> fea0: c0b20994 c04ad348 000000a9 e743834c e75705b0 57579938 c0b1d920 c0b20994
> fec0: e6cb2c00 c0b1d920 00000000 c04ae510 c083e4dc ffffe000 c0b20994 c0b20994
> fee0: c0b03008 ffffe000 c0a1b950 c04afee0 c0b2fb80 c0b03008 ffffe000 c0101710
> ff00: e74385d6 c0134194 c0984550 c0919800 00000000 00000006 00000006 c08cf26c
> ff20: 00000000 c0b03008 c08d8c7c c08cf2e0 00000000 e74385bf 00000000 57579938
> ff40: 00000000 c0b2fb80 00000007 57579938 c0b2fb80 c0a33094 c0984550 00000007
> ff60: e7438540 c0a00ed8 00000006 00000006 00000000 c0a003f0 00000000 c0a003f0
> ff80: 00000000 00000000 c073a390 00000000 00000000 00000000 00000000 00000000
> ffa0: 00000000 c073a398 00000000 c0100148 00000000 00000000 00000000 00000000
> ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [<c01cf678>] (__get_vm_area_node) from [<c01cf788>] (get_vm_area_caller+0x48/0x50)
> [<c01cf788>] (get_vm_area_caller) from [<c0162be4>] (__dma_common_pages_remap+0x1c/0x50)
> [<c0162be4>] (__dma_common_pages_remap) from [<c0162cd4>] (dma_common_contiguous_remap+0x7c/0xbc)
> [<c0162cd4>] (dma_common_contiguous_remap) from [<c010e384>] (__alloc_remap_buffer+0x50/0x88)
> [<c010e384>] (__alloc_remap_buffer) from [<c010e3e4>] (remap_allocator_alloc+0x28/0x30)
> [<c010e3e4>] (remap_allocator_alloc) from [<c010e510>] (__dma_alloc+0x124/0x240)
> [<c010e510>] (__dma_alloc) from [<c010e6a8>] (arm_dma_alloc+0x40/0x48)
> [<c010e6a8>] (arm_dma_alloc) from [<c0161760>] (dma_alloc_attrs+0x9c/0x110)
> [<c0161760>] (dma_alloc_attrs) from [<c016182c>] (dmam_alloc_attrs+0x58/0x98)
> [<c016182c>] (dmam_alloc_attrs) from [<c054176c>] (dwc2_gadget_init+0x31c/0x3fc)
> [<c054176c>] (dwc2_gadget_init) from [<c053afb0>] (dwc2_driver_probe+0x314/0x580)
> [<c053afb0>] (dwc2_driver_probe) from [<c04b0e9c>] (platform_drv_probe+0x48/0x98)
> [<c04b0e9c>] (platform_drv_probe) from [<c04af098>] (really_probe+0x1e0/0x344)
> [<c04af098>] (really_probe) from [<c04af338>] (driver_probe_device+0x60/0x168)
> [<c04af338>] (driver_probe_device) from [<c04af5e0>] (device_driver_attach+0x58/0x60)
> [<c04af5e0>] (device_driver_attach) from [<c04af640>] (__driver_attach+0x58/0xcc)
> [<c04af640>] (__driver_attach) from [<c04ad348>] (bus_for_each_dev+0x74/0xb4)
> [<c04ad348>] (bus_for_each_dev) from [<c04ae510>] (bus_add_driver+0x1b4/0x1d4)
> [<c04ae510>] (bus_add_driver) from [<c04afee0>] (driver_register+0x74/0x108)
> [<c04afee0>] (driver_register) from [<c0101710>] (do_one_initcall+0x7c/0x1cc)
> [<c0101710>] (do_one_initcall) from [<c0a00ed8>] (kernel_init_freeable+0x15c/0x1d4)
> [<c0a00ed8>] (kernel_init_freeable) from [<c073a398>] (kernel_init+0x8/0x110)
> [<c073a398>] (kernel_init) from [<c0100148>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xe745ffb0 to 0xe745fff8)
> ffa0:                                     00000000 00000000 00000000 00000000
> ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Code: eb005d92 e1a00008 e28dd00c e8bd83f0 (e7f001f2) 
> ---[ end trace 4ae52726a37c07c2 ]---
> Kernel panic - not syncing: Fatal exception in interrupt
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
>>
>> Thanks
>> Kishon
>>
> 
> 
> Thanks,
> Jonathan
> 
