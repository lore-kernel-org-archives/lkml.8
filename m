Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86AAC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B792D21582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1TPVvGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgBCPL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:11:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39173 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgBCPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:11:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so17582898wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=10knLupHMqEpgP8COf2Z7ZaOZSp04mKff+ekSwBxxho=;
        b=m1TPVvGc4/0Di91loBU1fx40PngrXZV3RmtMXQwng7gbLrcFo5pER+2Devadv35vE5
         SNdw9CG6c9hGdyik3GPRkLlqgKjcZLx7S+XNsZKOVN9jWtzH48cFriI+z7mbfLzYfQNn
         2Lgb0v0Kh2OPa4AIifYG7ixaH1xp33A+vKguI/QnHMNpsWmz0McsrgV3Rp+xQdmw023H
         ohpaX8T9l5uUZIRwGQdc5lDxaJIZnr8dgoDdimqykuHIo0AYieViOkVjeSJZPB67trSx
         HwmjSIuSC2dBgDvZB3rR7wAqkRNunzUAzurqrWGWp2+zDeitVBeqdXoP5gA8BYi6OS/b
         Hefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=10knLupHMqEpgP8COf2Z7ZaOZSp04mKff+ekSwBxxho=;
        b=lQDe6ur0Xk6lG3nk0dDA8cxOukjaIHN0LljW/smWefEeXTSEWxfCLvbRHHS81SU354
         1nylUomSgEDtsIHdHHQBYc/MkWatlRGgmZxeoJnF1NfON1gAwuoFIeWEaTeLqhCfvHKj
         w9HjaORSYGYESsRg/aGoahnz/d07eB7lV2JkERc0iZJ3gMh/G+hwzYOIwc/Nfoyv0fba
         7wYxs+Z9gyfgb0aklzX9NMbgcbRcy4ChYrJmEvDoi6hulDTx61nfDtMhJlbiMSItOozl
         6MYpMtNwtfQCHTW9IEzNM/96UryZZU3B+ZFCnNlPLLrWP61OJoSpdiSeBgYuY/1e+0K4
         yXtw==
X-Gm-Message-State: APjAAAVVo0r/j8OuZLoSDrlKOKfqEGFuyIrVg9mqevGq4aV6RqExbc2V
        upaOLth5bcIvIJbBCjHw4x1R3vVkCIc=
X-Google-Smtp-Source: APXvYqxY1XGUX6kA63UZ+k9EtOdPU9xCyzWL2gtWssT8Uoj5LsIGIEcm4B0qCnQvGZmzL8O3nZlqTg==
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr29207137wmj.134.1580742714891;
        Mon, 03 Feb 2020 07:11:54 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id z133sm24980737wmb.7.2020.02.03.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 07:11:54 -0800 (PST)
Date:   Mon, 3 Feb 2020 15:12:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] media: si470x-i2c: Move free() past last use of
 'radio'
Message-ID: <20200203151208.GD15069@dell>
References: <20200203132130.12748-1-lee.jones@linaro.org>
 <20200203143245.GA3220000@kroah.com>
 <20200203145831.GA3238182@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200203145831.GA3238182@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Feb 2020, Greg KH wrote:

> On Mon, Feb 03, 2020 at 02:32:45PM +0000, Greg KH wrote:
> > On Mon, Feb 03, 2020 at 01:21:30PM +0000, Lee Jones wrote:
> > > A pointer to 'struct si470x_device' is currently used after free:
> > > 
> > >   drivers/media/radio/si470x/radio-si470x-i2c.c:462:25-30: ERROR: reference
> > >     preceded by free on line 460
> > > 
> > > Shift the call to free() down past its final use.
> > > 
> > > NB: Not sending to Mainline, since the problem does not exist there.
> > 
> > It doesn't exist there because of a bad merge?  What commit caused the
> > problem?
> 
> Ah, found it, it was 2df200ab234a ("media: si470x-i2c: add missed
> operations in remove")

I was about to follow up with a v2:

  "NB: Cauased during the backporting of upstream commit 2df200ab234a
   ("media: si470x-i2c: add missed operations in remove").  This issue does
   not exist in Mainline since the kfree() was removed in v5.0 as part of
   commit f86c51b66bf6 ("media: si470x-i2c: Use managed resource helpers")."

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
