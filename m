Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE21C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308AB20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgGBPCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:02:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:43273 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgGBPCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:02:52 -0400
IronPort-SDR: ucuLy4blN1beFdCOl9mgxRgssnjxOXGLMVduG8jc/EjBU7ISPWxphFCNrwwCN4oBY3/gix4IST
 rRJ7aYF7/HtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134384102"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="134384102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 08:02:41 -0700
IronPort-SDR: W/iS25Y2HU7wr+H0UDFRVD3TdGcuFXMVpdLnjPeZ9a4kObj1kYA7x++obbTVf6rR1WgJA/yPNp
 LlVVPdTUSaZw==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="304275473"
Received: from nchava-mobl1.amr.corp.intel.com (HELO [10.252.135.144]) ([10.252.135.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 08:02:40 -0700
Subject: Re: [PATCH] riscv: asm/gdb_xml.h: use __maybe_used to make W=1
 warnings go away
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        kernel test robot <lkp@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200701184751.84008-1-pierre-louis.bossart@linux.intel.com>
 <CABvJ_xhm9a0nzBJ2YKvwm5vKZt3Xp0H9z6QakD0EYK7vRR-_AA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f148580a-f97d-3416-ca03-c3a425189568@linux.intel.com>
Date:   Thu, 2 Jul 2020 09:20:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABvJ_xhm9a0nzBJ2YKvwm5vKZt3Xp0H9z6QakD0EYK7vRR-_AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/20 9:04 PM, Vincent Chen wrote:
> On Thu, Jul 2, 2020 at 2:48 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> 0day/kbuild reports warnings with the ASoC codecs compiled with W=1.
>>
>> In file included from arch/riscv/include/asm/kgdb.h:109,
>>                   from include/linux/kgdb.h:20,
>>                   from include/linux/fb.h:5,
>>                   from include/drm/drm_crtc.h:31,
>>                   from sound/soc/codecs/hdmi-codec.c:19:
>>
>> arch/riscv/include/asm/gdb_xml.h:23:19: warning:
>> 'riscv_gdb_stub_cpuxml' defined but not used [-Wunused-const-variable=]
>>     23 | static const char riscv_gdb_stub_cpuxml[2048] =
>>        |                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/gdb_xml.h:16:19: warning:
>> 'riscv_gdb_stub_target_desc' defined but not used [-Wunused-const-variable=]
>>     16 | static const char riscv_gdb_stub_target_desc[256] =
>>        |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/gdb_xml.h:13:19: warning:
>> 'gdb_xfer_read_cpuxml' defined but not used [-Wunused-const-variable=]
>>     13 | static const char gdb_xfer_read_cpuxml[39] =
>>        |                   ^~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/gdb_xml.h:10:19: warning:
>> 'gdb_xfer_read_target' defined but not used [-Wunused-const-variable=]
>>     10 | static const char gdb_xfer_read_target[31] = "qXfer:features:read:target.xml:";
>>        |                   ^~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/gdb_xml.h:7:19: warning:
>> 'riscv_gdb_stub_feature' defined but not used [-Wunused-const-variable=]
>>      7 | static const char riscv_gdb_stub_feature[64] =
>>        |                   ^~~~~~~~~~~~~~~~~~~~~~
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>
>> I don't know if this is the right way of solving this issue but this
>> error is now consistently thrown in kbuild compile-test reports w/
>> W=1.
>>
> 
> Dear Pierre-Louis Bossart:
> Thanks for your modifications. I have fixed the warnings in my latest
> KGDB patchset and sent it out, but the merged KGDB patchset is not my
> latest version.
> I have sent a patch set to complement the missing ports, and I think
> these warnings would disappear after this patch has been accepted and
> merged.
> 
> Here is the patch to fix this warning:
> http://lists.infradead.org/pipermail/linux-riscv/2020-June/000660.html

Thank you Vincent, let's drop my hacky patch then.
