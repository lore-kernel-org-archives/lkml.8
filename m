Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F605C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25664206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8tARiBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDQU64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDQU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:58:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8107C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:58:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ms17so1562953pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IPeJXG06ZWSjID1ZSrk68zz6iipUS238/wcn3J1nBio=;
        b=r8tARiBnDehpRMpjOnDPEGZJxST7s2t5Nm4jmrXcz4Lg+uS8bFIDERNgCLzQgXJ5hC
         7vPPn7RLIio7Py2VMxGt0bbRmhnBK+EqvawRztLY4orZcpd3s020wG2vpVPv9GHGyVYS
         4vSvuBbxRKwlrXtbsdSD64aYlh/ann3Xo/2VADYnAOGjkCRLEpstfET7SeR0YWeUnvAf
         od9ix1eI0NH5bN9d7BcyZ902rUiQWAL9jk7q4pFT53jPfriTTPK6iN7jg+V8ax8QM9DA
         RteUMabdDzbErzz4unTh4mG9GicUcv8jJKals9+oQkAGIoERu0JFFkRIZyux5URMoKi+
         yjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IPeJXG06ZWSjID1ZSrk68zz6iipUS238/wcn3J1nBio=;
        b=UPgtdlN9NenOHlfXuDY7tBge3rihWwtDK6y8wN/ulSFul3G1PrTu3e2buUAH38bwpU
         W7uwK52yDf1APTlw2CrFL2vglRorbVyag8wxrZlAhk2jhimNc1d/LZ+3aufubF5waLXS
         2uDobV/PAkTVY0ypkRTVTUc9VflcmdPba0sneK+rbdWrRQvrgMh7oo9bJu5SiLX3zyjx
         DyE5FjxlzQ0LpoO5OCzCQIwIvX3ndOpHzDH8F+OEG2Wh7w4KFHYdRhrKQL/9xJ8BShaY
         agJXGE/AWjWLwypO2xLyTDlGZsk6OeMG4NrHjBpyGri4I6aMBxhrwGoWFALUhsfooxgd
         uhsg==
X-Gm-Message-State: AGi0PuY8AO70alVAAtR7nKQSJq5uSgZJ++Xf7i+SsCbAW5uFVCL84hri
        TUn+s3MHBcqdm1mODa+DZiETDw==
X-Google-Smtp-Source: APiQypLoltWczEfKnuHpDYUDGkgjfP5vNaxQfZtow0WTBt477E3OAVR2PBMnhJkeRmloh3H125zOrg==
X-Received: by 2002:a17:90a:d3ca:: with SMTP id d10mr6932745pjw.24.1587157135366;
        Fri, 17 Apr 2020 13:58:55 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i15sm8739514pfo.195.2020.04.17.13.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 13:58:53 -0700 (PDT)
Date:   Fri, 17 Apr 2020 14:58:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [v2 5/7] remoteproc: Restructure firmware name allocation
Message-ID: <20200417205851.GA10372@xps15>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-6-mathieu.poirier@linaro.org>
 <aa565fea-b1c4-9b5c-73ed-591244afee19@web.de>
 <e887c990-8cba-62b0-0f47-3ea0c166d603@ti.com>
 <7a978c24-945d-8d39-3a0a-30e0678d569a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a978c24-945d-8d39-3a0a-30e0678d569a@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Fri, Apr 17, 2020 at 05:48:49PM +0200, Markus Elfring wrote:
> >>     p = firmware ? kstrdup_const(…) : kasprintf(…);
> >
> > For simple assignments, I too prefer the ternary operator,
> 
> Thanks for your feedback.
> 
> 
> > but in this case, I think it is better to leave the current code as is.
> 
> Would you like to consider the use of the function “kvasprintf_const”
> according to your review comment for the update step “[PATCH v2 4/7] remoteproc:
> Use kstrdup_const() rather than kstrup()”?
> 

Looking at the implementation of kvasprintf_const(), using it here wouldn't give
us anything.  Indeed allocation of duplicate memory is avoided only if the
string is pre determined of if it is exactly %s, which isn't the case here.
Otherwise things default to kvasprintf().

Thanks,
Mathieu 

> Regards,
> Markus
