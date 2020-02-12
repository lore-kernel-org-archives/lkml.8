Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537C1C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF3720873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UakYPEeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBLGb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:31:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgBLGb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:31:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so552656pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F5k8IJZMK/nJH3dj+UN04HFPptBmFYQ7C5BtIcmZek0=;
        b=UakYPEeNTs9w07NmJnHfIv49QPaAus+cJ3pOa2Iwbn3RDrKxNv1gtczYgPdMXdoy8+
         8rJrmqryb5R4tSr5uRKRdBrLLjVWj2oGtrEmYm8sqCmlWvP5t/f4N3K1cR1UNTJbi9p4
         hfoM09VYb9ouO9I3XsIDL3L+jQx6oDeqnC4fkzxfA3pjGHWTV/6KfHD5CUpvbkjcncIG
         xCNFIHwLfK5siX/ywTFhPH9Zh0EK1fT6opNKNCTn5BvcMo03SpHBFsIx0+S6WZf8Xflb
         o9F8f2ptFpzVMPESj/J2Qt3T58HbnD4cL5wt9NwUQR0x7nd2boWNz7mXIOr81LQYWXmk
         +G4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F5k8IJZMK/nJH3dj+UN04HFPptBmFYQ7C5BtIcmZek0=;
        b=kxV+1oHhrW5QbWLDwIFPS1iRTkYnMLNJMohygBeJvjSwU30+LQPfvH/ggXbpr1440R
         dfqeDLCJ/P/aSjGdTZbyD3DnGLcBazt2idTBxvchhxxo4vm3tiyeI1+lzUnRZvg8kLnV
         QT+dMlF8VkRr6KNbbUPeO02Ro3IWO9yrauwxIn3sZ45pIM7/ZKfpDX18uyWSRZz9afx8
         gwOdVMYTwXCcu6fWRG4ZGuM6pcPtRzzwpC5Fbl2P0e9xkGlTWrQTO17kxV/h/4BXJ5V2
         p2xHL3b1A+6+/MM/AKiFv1qPDoiwysfQSu0dK4SsDEE76DZKov3wpsjjHWC1U0gIM9ix
         OjcA==
X-Gm-Message-State: APjAAAWiv53MGWiBCvP4qahN8goY+B97fHxIisFUUc+ZtCS1yNA48Tdn
        GFCgaZSRXpxmrUqWrjXLuGUBlg==
X-Google-Smtp-Source: APXvYqxqBFIjlK2CH6hHv/Pfjn8B3oh3xX5ZsrKSB1m0GcV7iChIZoGq8iMbPygRkv3wUCesoiddkA==
X-Received: by 2002:a17:902:262:: with SMTP id 89mr6945138plc.67.1581489117661;
        Tue, 11 Feb 2020 22:31:57 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y64sm6043527pgb.25.2020.02.11.22.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 22:31:56 -0800 (PST)
Date:   Tue, 11 Feb 2020 22:31:54 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     clew@codeaurora.org, Andy Gross <agross@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: aoss: Use wake_up_all() instead of
 wake_up_interruptible_all()
Message-ID: <20200212063154.GO3948@builder>
References: <1579681417-1155-1-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579681417-1155-1-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Jan 00:23 PST 2020, Arun Kumar Neelakantam wrote:

> During the probe the task is waiting in TASK_UNINTERRUPTIBLE state which
> cannot be woken-up by wake_up_interruptible_all() function.
> 
> Use wake_up_all() to wake-up both TASK_UNINTERRUPTIBLE and
> TASK_INTERRUPTIBLE state tasks.
> 
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Applied

Regards,
Bjorn

> ---
>  drivers/soc/qcom/qcom_aoss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index 006ac40..fe79661 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -200,7 +200,7 @@ static irqreturn_t qmp_intr(int irq, void *data)
>  {
>  	struct qmp *qmp = data;
>  
> -	wake_up_interruptible_all(&qmp->event);
> +	wake_up_all(&qmp->event);
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 1.9.1
