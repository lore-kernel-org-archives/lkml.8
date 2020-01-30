Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5965BC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 03:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B8E20707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 03:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X5WxJNIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgA3DtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 22:49:22 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35417 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgA3DtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 22:49:21 -0500
Received: by mail-pj1-f66.google.com with SMTP id q39so754418pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 19:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mx3OfgZqXsctX/7U2mChFWk0zCA5WCpqANSbySekotA=;
        b=X5WxJNIxpSC+SU8kzTSE8BPBlHNsC3v2pics92oUneEjfoADck4fpsPjTXSusetKXQ
         nK4PNWKk8uh9KjelGQEwiMfCiL2qdr/3svDDzNCH1oucd5jhkAmhMYCvh8mfASipTnkF
         T8RqVUCZ2o/Yl43yiwZblg7Af00qVPSSrPOIm6qsS20UKHhNyWmmiBokPS8vKgB1igQI
         D9epvWXGqfWMkQ816eZmvCaj1QTDg2k/q5U81u3VC4XQUSY7UyBneATwfsNj688+XnRE
         CgfuPIeZor4SgKB1iYnw0XDY1J09DhXLO6f2o+e9Jb2atWT5wL6ENBW1GrgUtlD9VdHT
         wSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mx3OfgZqXsctX/7U2mChFWk0zCA5WCpqANSbySekotA=;
        b=BCynu6HyDvB5opRXWtuiZWCAySKfZ40o6aaAH+anjOB5Nn82XSLXZ7pfVsp/+pDUUs
         77pgo7IoP8xL/kogXuJm5KVTVstTwr/R262svE2s/HDkXtR4jMIfLlSr5HPL7dRnfZWU
         jn0O0mzjCVNS/V5pBc7z6rzgHRQ4n/JQCRVxVP+GAA6E+yh67kHFd2dI6kQwUacFlpIG
         Hep2i8dxFr1ii8Y7tIJ8d2F3foUA4xJ+yq7Tx1p1H5KCcl8Bw7HkPJHfy6b4wCDv21m3
         2D4qiPX7aHNNJeqgm/mEvLx+pgn4HItOdNpTVttOER4GFyw8Rq3Yn0a+hVbJzMEMySZe
         YyhQ==
X-Gm-Message-State: APjAAAX0rYddosJCBD8AWO+uhw5fMY/oEntoq4f8SA9J5UAfuiKc/A4H
        Ci1DZHdPEseNUrqnzZW+5FLUYA==
X-Google-Smtp-Source: APXvYqzLfb+nyZJcIxNwxOwzMRDzIIFuTpHf+Jcuu9CPDAACZJjS4KoRWngbSUk7D98OohGdNUOGRA==
X-Received: by 2002:a17:902:82c3:: with SMTP id u3mr2615891plz.73.1580356160930;
        Wed, 29 Jan 2020 19:49:20 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id t23sm4413520pfq.6.2020.01.29.19.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 19:49:20 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Add Revanth Rajashekar as a SED-Opal
 maintainer
To:     Jon Derrick <jonathan.derrick@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
References: <20200110215646.15930-1-jonathan.derrick@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9d2ecfd-c6b9-ac0f-ac93-30329d9982b2@kernel.dk>
Date:   Wed, 29 Jan 2020 20:49:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200110215646.15930-1-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 2:56 PM, Jon Derrick wrote:
> Scott hasn't worked for Intel for some time and has already given us his
> blessing.

Applied, thanks.

-- 
Jens Axboe

