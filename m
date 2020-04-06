Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043EAC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2A42063A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxoICYCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgDFKI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:08:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34240 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgDFKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:08:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so16721081wrl.1;
        Mon, 06 Apr 2020 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=pxoICYCZQS7Mzt5lAR24RYW1cuT93hpaA5+n0m7bNjt79njheoWOcIjuvkb44yyLFF
         rp4q7KYaZR5udual8Mp8j5dnhxcWHyG8uecj1e15/2KvqMUIPovLmlpynMHbFKmByaoI
         3h3axgD2h5b1LO1VRDIHDuOOUS89czc0Fr2Z0Drg+vV4JXycfYaL74Epube5yofIONcC
         81TPSnjxaRlwteYYCm7tJKr8sqG/d/0dwviVAwZGXdyhtqmvizNeSz+sLSGsFmrwin1m
         sN4GL4DSzhTOA9xHZqPuc+cTHReWYU0MK9+GjjbECmBSnJxHg5WTX1+7qxYVHzeQX3q0
         CrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=prIUl9+1KvJgd1x/3GROmpz16C6XLcszhBE5o8ATXKZOBR0PXP9HOkDaWjim8HlvUw
         khXFRD+E7qhgk03aaNm0ND6JRC6WbSbQ+iI/69cQ3ahQ0FfuBLoHDRFLsAS2qfhurKhD
         HKmsl0fYhBOVFyzb9lBqkaY76NYftySerhB8n+tbpQFLRAYSYUfol4ojJKXoKjSBP35M
         YqFlpAI9cP0vXvG9dXVl8xOgIEPZJk5cHIYfSfRtCjEgE/akhp9TgqWDRIM+HY6WsZCv
         kON44W54LhLBfMRUy88APnh0XIxJzgOgWd5iuqICCY2CgOYUZg7xei8m76YuLujM8f+j
         EC5g==
X-Gm-Message-State: AGi0PuazZ1oN8bA8NDxagz61GRP4+WHLHGY1Ldhs1zCN7XhJQB0E5cni
        Hg0q+MgKpymRxSaGm9e4//c=
X-Google-Smtp-Source: APiQypKT92w1IJdahe4OdzeoC7iyiOJq/yEXRrgZFi6fmM8BbWCdGwkLm3cnmjdvbBLeFk1NJXR81A==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr3959235wrt.362.1586167703938;
        Mon, 06 Apr 2020 03:08:23 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y1sm17999252wmd.14.2020.04.06.03.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 03:08:23 -0700 (PDT)
To:     heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        mark.rutland@arm.com, robh+dt@kernel.org
References: <20191219121954.2450-1-jbx6244@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: remove disable-wp from
 rk3308-roc-cc emmc node
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <cdad08bb-6857-3c1a-aead-9313252cf793@gmail.com>
Date:   Mon, 6 Apr 2020 12:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20191219121954.2450-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping
