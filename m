Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB86920760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TlbRof+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGPH7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgGPH7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:59:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F01C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:59:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so10399853wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uG4bBgdzPJcKA1q7g4FtFtpm2iBs2j/GM+Sb6kg25uc=;
        b=TlbRof+rYJlkBPf8XiptFqKuw2HrpXZ1VY4dgL8lhgvotH8WSLyZ6WM5ruscewMAa/
         xc8y9a9PChZfMkR5G0/NVytcBx4Y9PVe3GR7dLCSUBzo7OBL+RpyOd1TCZfT2kenRSsg
         0mbN78mKxk+0+yPRqC3otegshWkTJX8r1/kG3NQ7V7HFd2D0LmYH+ySmqG3N2ePvboKZ
         R3bwfzAraRNU6h2ioXevSw5Q93gTIOF3UqNyryoZYAnnxWv9zPvWDsRpEOEtp5i+LSr6
         P3OrcHrF6qrr3+O8Mnp1vLE7RlOmhgFRni+aJZ0IjGln2bX3swC8L9sB6lVb+cH6j0bN
         TXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uG4bBgdzPJcKA1q7g4FtFtpm2iBs2j/GM+Sb6kg25uc=;
        b=gXJ8PUaRFcZQj4W4us2mNq0o8TQEc3ZBss7HVt8H66vmT2YFhD68Eqsn5xOfZsA9ZC
         jpValEAMRt88TS88+JB4m7a9fb3arGHsfoT9dm9ryQKccPmurAo7pQPXNUYC3kVNrnUc
         emMdhAGjoLSUNbgWa3wLuiUNb/UKf7Z38yt9D2e+7+TINPnDuvxI0GwrC154kYQaCN6o
         7289+afrz8bd71C/QbN1Tf2ieZpCxm5z+w0RpB/X1FL+zlV3gkcH4Ds95mTHf7QXHd0w
         /fq3FfsgMWe1ZN+/2f9x/QBrjcCQLL3YOafG2BoObte/crQwSBvk9mS7qN6c46i5/58B
         Bq8w==
X-Gm-Message-State: AOAM532To7gOMdfnwr0H7AJQUQkHzjA3NNAqzhWLWHE5p08V71gCA3QB
        +DB7CjTbonhhdzU5ABzxe2rAtg==
X-Google-Smtp-Source: ABdhPJwOWKHeO5JFPkGEDdmH3ebAmbF9RF3hYNjhebMarBxozbvU+CI7OjLE5KoTSHn8veV3NC5PYA==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr3106237wma.18.1594886371110;
        Thu, 16 Jul 2020 00:59:31 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id m4sm6951240wmi.48.2020.07.16.00.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:59:30 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:59:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, support@areca.com.tw
Subject: Re: [PATCH 16/30] scsi: arcmsr: arcmsr_hba: Make room for the
 trailing NULL, even if it is over-written
Message-ID: <20200716075928.GN3165313@dell>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
 <20200708120221.3386672-17-lee.jones@linaro.org>
 <yq1h7u8o7ck.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1h7u8o7ck.fsf@ca-mkp.ca.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Martin K. Petersen wrote:

> 
> Lee,
> 
> > Ensure we do not copy the final one (which is not overwitten).
> >
> > -		strncpy(&inqdata[8], "Areca   ", 8);
> > +		strncpy(&inqdata[8], "Areca   ", 9);
> >  		/* Vendor Identification */
> > -		strncpy(&inqdata[16], "RAID controller ", 16);
> > +		strncpy(&inqdata[16], "RAID controller ", 17);
> >  		/* Product Identification */
> > -		strncpy(&inqdata[32], "R001", 4); /* Product Revision */
> > +		strncpy(&inqdata[32], "R001", 5); /* Product Revision */
> 
> SCSI INQUIRY strings are fixed length and not NULL-terminated. Please
> address this warning using either memcpy() or strlcpy().

Will do.  Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
