Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6094C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF16E20B80
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgE0BIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:08:12 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:48938 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728092AbgE0BIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:08:12 -0400
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 27 May 2020 09:07:40
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.60.151]
Date:   Wed, 27 May 2020 09:07:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Cc:     kjlu@umn.edu, "Cezary Rojewski" <cezary.rojewski@intel.com>,
        "Liam Girdwood" <liam.r.girdwood@linux.intel.com>,
        "Jie Yang" <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Allison Randal" <allison@lohutok.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alexios Zavras" <alexios.zavras@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ASoC: Intel: sst: Fix runtime PM imbalance in
 sst_power_control
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <922ac37c-0a5a-dff7-0cd7-d3487cf9ff00@linux.intel.com>
References: <20200525070701.3888-1-dinghao.liu@zju.edu.cn>
 <922ac37c-0a5a-dff7-0cd7-d3487cf9ff00@linux.intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <73fef900.d8158.17253abb08c.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCnEbxcvc1eVVkcAA--.3818W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0MBlZdtOUT6wAGsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbuCS07vEb7Iv0x
        C_Xr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
        82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
        v26r1j6r18MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
        JwCS07vEFIxGxcIEc7CjxVA2Y2ka0xkIwI1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6w
        4lV2xY6xkI7II2jI8vz4vEwIxGrwCS07vE42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMIAI
        bVCF72vE77IF4wCS07vE4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14v26r106r1rMIAIbVC2zVAF1VAY17CE14v26r1q
        6r43MIAIbVCI42IY6xIIjxv20xvE14v26r1j6r1xMIAIbVCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lV2xY6IIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIAIbVCI42IY6I8E
        87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAKPiB0aGlzIGNoYW5nZSBkb2Vzbid0IHNlZW0gcXVpdGUgcmlnaHQsIGlmIHlvdSBsb29rIHRo
ZSBjb2RlIGJlbG93IHRoZXJlIAo+IGlzIG5vIFBNIGltYmFsYW5jZSwgaXMgdGhlcmU/Cj4gCj4g
aW50IHNzdF9wbV9ydW50aW1lX3B1dChzdHJ1Y3QgaW50ZWxfc3N0X2RydiAqc3N0X2RydikKPiB7
Cj4gCWludCByZXQ7Cj4gCj4gCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koc3N0X2Rydi0+ZGV2
KTsKPiAJcmV0ID0gcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoc3N0X2Rydi0+ZGV2KTsKPiAJ
aWYgKHJldCA8IDApCj4gCQlyZXR1cm4gcmV0Owo+IAlyZXR1cm4gMDsKPiB9CgpZb3UgYXJlIHJp
Z2h0LiBUaGFuayB5b3UgZm9yIHlvdXIgY29ycmVjdGlvbiEKClJlZ2FyZHMsCkRpbmdoYW8K
