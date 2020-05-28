Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BB5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D683207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QugMqqM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404586AbgE1Poh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404518AbgE1Po3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:44:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6696C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:44:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 185so5414098pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/zE1r9PxY6UEdk2voI36d40mySx5vpu2AZb0S4BiO8M=;
        b=QugMqqM5vaYHQLLhqi3Ot6rcxeRNnN3bQNbPcrS2pY9pHbiZmXZ8Pw3pew58Txfuyq
         0+bY8+ASSBcH0vIsqkD8CvDKKCtDuhauNuodVWRNwHNLra6ZS7jm56vFAu4uPCj5N4Y+
         Dn50iFeFhuEsmKzfWaMrbOzr8q1yJdxtGwZ8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/zE1r9PxY6UEdk2voI36d40mySx5vpu2AZb0S4BiO8M=;
        b=c8AoCfPZdT0Yy7P96BWKy3hMBbsRVwgEM7vJryNHFjf//lYlF7AwYvwAcqPf7J5v/U
         w5tvs01Jdc7fED37WM4kj18HsEr0wJNbBn0Glbhu6rM6W9lgmJ2CCOzrXkYhiTMJe+Ev
         B1ZMhOboasbJ007U0Nw+5ToaEPwrcewjkv8VCxeL0ni8AkIaw0KvCTO+eeZnUyZf78qR
         ojX5MXm79SnDKE0sMSkOLBaO35vcSHMEh5B25lnoSlDgzrClSDMUv3hgNPUr6H+eCJXF
         wb08K0SA8y/ESbEqYNUbjMtAtUXSpAbhS+zAc9XjXRgPqZeXUTyuhexupUjRb8jBuyV3
         Ichw==
X-Gm-Message-State: AOAM530v+sXA0b4jkO5vQsfS6UYOvK82FxyxVO1Yuqy4pVsuO6LApwta
        IJopEm0nKyo22Tz0K8jJ8er9yw==
X-Google-Smtp-Source: ABdhPJwOzx2HAvaVw5ElM6KwTbwGOQJAcwFK2lEZW0sisJKqC/Yq5Ydi+qekdg6VyNRK7qI+xGmxpw==
X-Received: by 2002:aa7:855a:: with SMTP id y26mr3704572pfn.281.1590680668994;
        Thu, 28 May 2020 08:44:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id q9sm5018528pff.62.2020.05.28.08.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 08:44:28 -0700 (PDT)
Date:   Thu, 28 May 2020 08:44:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v3] bluetooth: hci_qca: Fix qca6390 enable failure after
 warm reboot
Message-ID: <20200528154426.GJ4525@google.com>
References: <1590546759-27387-1-git-send-email-zijuhu@codeaurora.org>
 <20200527164832.GH4525@google.com>
 <4c5c9fd8-e90c-c7e2-8f21-edad3c3ca7ff@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c5c9fd8-e90c-c7e2-8f21-edad3c3ca7ff@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 01:04:25PM +0800, Zijun Hu wrote:
> 
> 
> On 5/28/2020 12:48 AM, Matthias Kaehlcke wrote:
> > Hi Zijun,
> > 
> > On Wed, May 27, 2020 at 10:32:39AM +0800, Zijun Hu wrote:
> >> Warm reboot can not restore qca6390 controller baudrate
> >> to default due to lack of controllable BT_EN pin or power
> >> supply, so fails to download firmware after warm reboot.
> >>
> >> Fixed by sending EDL_SOC_RESET VSC to reset controller
> >> within added device shutdown implementation.
> >>
> >> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> >> ---
> >>  drivers/bluetooth/hci_qca.c | 29 +++++++++++++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>
> >> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> >> index e4a6823..4b6f8b6 100644
> >> --- a/drivers/bluetooth/hci_qca.c
> >> +++ b/drivers/bluetooth/hci_qca.c
> >> @@ -1975,6 +1975,34 @@ static void qca_serdev_remove(struct serdev_device *serdev)
> >>  	hci_uart_unregister_device(&qcadev->serdev_hu);
> >>  }
> >>  
> >> +static void qca_serdev_shutdown(struct device *dev)
> >> +{
> >> +	int ret;
> >> +	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
> >> +	struct serdev_device *serdev = to_serdev_device(dev);
> >> +	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
> >> +	const u8 ibs_wake_cmd[] = { 0xFD };
> >> +	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
> >> +
> >> +	if (qcadev->btsoc_type == QCA_QCA6390) {
> >> +		serdev_device_write_flush(serdev);
> >> +		serdev_device_write_buf(serdev,
> >> +				ibs_wake_cmd, sizeof(ibs_wake_cmd));
> >> +		serdev_device_wait_until_sent(serdev, timeout);
> > 
> > Why no check of the return value of serdev_device_write_buf() here,
> > does it make sense to continue if sending the wakeup command failed?
> > 
> i will correct it at v4 patch
> > Couldn't serdev_device_write() be used instead of the _write_buf() +
> > _wait_until_sent() combo?
> > 
> i don't think so, serdev_device_write() is not appropriate at here.
> serdev_device_write_wakeup() should be used to release completion hold
> by serdev_device_write(), however @hci_serdev_client_ops doesn't use
> serdev_device_write_wakeup() to implement its write_wakeup operation.
> we don't want to touch common hci_serdev.c code.

Thanks for the clarification!

> >> +		usleep_range(8000, 10000);
> >> +
> >> +		serdev_device_write_flush(serdev);
> > 
> > I suppose the flush is done because _wait_until_sent() could have timed out.
> > Another reason to use _device_write() (if suitable), since it returns
> > -ETIMEDOUT in that case?
> >
> flush is prefixed at write operation to speed up
> shutdown procedure in case of unexpected data injected
> during waiting for controller wakeup.

hm, wouldn't it be a bug if unexpected data is injected during shutdown? It
seems it would be better to detect such a problem and fix the root cause,
rather than papering over it.

Also, a flush doesn't really guarantee that there is no unexpected data when
serdev_device_write_buf() is called, it could be injected just after returning
from _flush().
