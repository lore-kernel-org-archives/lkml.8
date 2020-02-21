Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714A1C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D0206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgBUI4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:56:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727670AbgBUI4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:56:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A9C6B24B492927AD0DB8;
        Fri, 21 Feb 2020 16:56:13 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Feb 2020
 16:56:05 +0800
Subject: Re: [PATCH] drm/hisilicon: Fixed pcie resource conflict using the
 general API
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <puck.chen@hisilicon.com>, <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1582264523-61170-1-git-send-email-tiantao6@hisilicon.com>
 <CAKoKPbztX8--gWgLDYJFQX1=Wf1jiFKx+H2_RFN90fxOpr_RdQ@mail.gmail.com>
 <e65e3728-406e-ff9c-a8ef-6829666fa573@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <4a8ba960-34c5-d044-900d-5cd0e9ec310e@huawei.com>
Date:   Fri, 21 Feb 2020 16:56:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e65e3728-406e-ff9c-a8ef-6829666fa573@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,my mistake. I sent the wrong patch, please ignore the patch below

在 2020/2/21 16:52, Thomas Zimmermann 写道:
> Hi
> 
> Am 21.02.20 um 08:06 schrieb Xinliang Liu:
>> Hi tao,
>> Are you sending a wrong patch?
>> Function hibmc_remove_framebuffers is added by your prior reviewing patch.
>> Please send patch based on drm-misc-next branch[1] or linux-next.
> 
> There's drm_fb_helper_remove_conflicting_pci_framebuffers() which
> already implements the functionality. I asked to try using it instead of
> creating an own implementation.
> 
> Best regards
> Thomas
> 
>>
>> Thanks,
>> -Xinliang
>>
>> [1] https://anongit.freedesktop.org/git/drm-misc.git
>>
>> On Fri, 21 Feb 2020 at 13:56, Tian Tao <tiantao6@hisilicon.com
>> <mailto:tiantao6@hisilicon.com>> wrote:
>>
>>      the kernel provide the drm_fb_helper_remove_conflicting_pci_framebuffer
>>      to remvoe the pcie resource conflict,there is no need to driver it
>>      again.
>>
>>      Signed-off-by: Tian Tao <tiantao6@hisilicon.com
>>      <mailto:tiantao6@hisilicon.com>>
>>      ---
>>       drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 22
>>      +++++-----------------
>>       1 file changed, 5 insertions(+), 17 deletions(-)
>>
>>      diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>      b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>      index 7ebe831..0f7dba7 100644
>>      --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>      +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>      @@ -47,22 +47,6 @@ static irqreturn_t hibmc_drm_interrupt(int irq,
>>      void *arg)
>>              return IRQ_HANDLED;
>>       }
>>
>>      -static void hibmc_remove_framebuffers(struct pci_dev *pdev)
>>      -{
>>      -       struct apertures_struct *ap;
>>      -
>>      -       ap = alloc_apertures(1);
>>      -       if (!ap)
>>      -               return;
>>      -
>>      -       ap->ranges[0].base = pci_resource_start(pdev, 0);
>>      -       ap->ranges[0].size = pci_resource_len(pdev, 0);
>>      -
>>      -       drm_fb_helper_remove_conflicting_framebuffers(ap,
>>      "hibmcdrmfb", false);
>>      -
>>      -       kfree(ap);
>>      -}
>>      -
>>       static struct drm_driver hibmc_driver = {
>>              .driver_features        = DRIVER_GEM | DRIVER_MODESET |
>>      DRIVER_ATOMIC,
>>              .fops                   = &hibmc_fops,
>>      @@ -343,7 +327,11 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>>              struct drm_device *dev;
>>              int ret;
>>
>>      -       hibmc_remove_framebuffers(pdev);
>>      +       ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev,
>>      +
>>       "hibmcdrmfb");
>>      +       if (ret)
>>      +               return ret;
>>      +
>>
>>              dev = drm_dev_alloc(&hibmc_driver, &pdev->dev);
>>              if (IS_ERR(dev)) {
>>      --
>>      2.7.4
>>
> 

