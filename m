Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227BDC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E180E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HZBmgujy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCLOHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:07:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44549 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgCLOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:07:08 -0400
Received: by mail-io1-f67.google.com with SMTP id t26so5788882ios.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oCQZrJERoMLVJX5x1RC4/10D7o7Of6OtemKn4HOrLdo=;
        b=HZBmgujyPwgpUWYM7/HORgiCG38xaFHF4dYp9PfcCMwQa+VsSrfX1QcCEV2O/gT9vK
         B22yMEuG1CTTNBqtIWim7JaRHZbNhqTEyNTkewt4OlSchidYGqNM+X65o6BmOlfKKdWJ
         vFUIdRFg27zaJ17A5rcanFIFhmm7tRiYuYDLME0juq80YONBxlRydi7cp23gx7xGnPS3
         5rJTQNK5CjmvMY4T9Sbi5exCPfZBvZpNO8MVzLXVYCky0fr9MbFSRN8OvuiVYcfIqrgl
         m2sraVlEwzs3T2Ku8sZdFVk9PNNSoe/6aBqiEaW/dlyxt/iHPTCHRezZ4zKu7YdhfszQ
         V48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oCQZrJERoMLVJX5x1RC4/10D7o7Of6OtemKn4HOrLdo=;
        b=AGjKrSKOuNiLVpx6e7N0GMRFo9JkqmfdSSPZ+RWrrpL2hbIz2XAIlYQlZ1CJY0NZbg
         sc0i6vidCY72uqfq1trauimhfDYK1aCZp7k4aAMLPx1d2qkATxSmBxglOrnMlIP3FHxh
         OatkC96hRFkVv/ake+OEUqa8hCFO3M1BxQPdytJdqV2vvq7QBgED625pp92TEfehNYK1
         4hC6R8ufSMb8LMVO7ZlETTjafJaUoTvNm5n0YzljBp4P821FIHvoPwAS56E31OtSQCfI
         nWvLLwr+bm9k7HZupK+6H1teCY5Hneb22Syd+hUDRteDAeTB31BIdWFA4dmGlR301xOB
         zxdw==
X-Gm-Message-State: ANhLgQ0y1HfQqfjHHLxEgpyZ9fAFqA4ThuED+TAr0wxMwG+sZke76OBq
        h9YXmM0Gd+ZT+dpMjYNE81zpDiXGk5H9cw==
X-Google-Smtp-Source: ADFU+vtKS38s0PCAkBWNDJM2Ky4G6/1a8TBXyV4tWFrtvcbpgq9gguaRafM1XlKHiVjI2Je1z3pj3Q==
X-Received: by 2002:a6b:f118:: with SMTP id e24mr7955975iog.54.1584022026659;
        Thu, 12 Mar 2020 07:07:06 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l6sm193178ilh.27.2020.03.12.07.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:07:05 -0700 (PDT)
Subject: Re: [PATCH] ahci: Add Intel Comet Lake H RAID PCI ID
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     stable@vger.kernel.org,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200227122822.14059-1-kai.heng.feng@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e471538-0d7d-534d-6de6-27213cfb36d8@kernel.dk>
Date:   Thu, 12 Mar 2020 08:07:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227122822.14059-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 5:28 AM, Kai-Heng Feng wrote:
> Add the PCI ID to the driver list to support this new device.

Applied for 5.7, thanks.

-- 
Jens Axboe

