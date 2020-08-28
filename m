Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77BC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1615B20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Whppa+bZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgH1USG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgH1USD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598645882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWyHfTHifX4s3mVQhhcUAJcvryyZ6mo0hzR0AcO35fk=;
        b=Whppa+bZpo+1zTU+t5CcmD1uwl+LQRfHX8YHKtIpJ/1ZtwwD5mytcx7yJBJxB0WG0ZrpAu
        0TJxVEjveRLF5jH9QKYxqNfe3W9C9jwz3CTBRDf5kqIGCa+Z3pgi0PMLbd0tZXRoOHZTCW
        h2moTccYeGQrn1sBFF29m+ykQSCOOQ8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-Ox3fh0q_PQWeC47cgxkT9w-1; Fri, 28 Aug 2020 16:18:00 -0400
X-MC-Unique: Ox3fh0q_PQWeC47cgxkT9w-1
Received: by mail-oi1-f200.google.com with SMTP id p4so184279oic.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KWyHfTHifX4s3mVQhhcUAJcvryyZ6mo0hzR0AcO35fk=;
        b=dBpLEAuPLGXs4YgGENRo6PRPRVLIChl4bRBp4xtG9Hpos2zR2zwHj8bKVJ+853Lh5C
         b4RGz+9XXfZjzVnddIvcT2GB3xTZX2eSZeFj50r7TCzJF1E7aFQEAUZOPX5EB8G7zJ/X
         uxkkNoCUnGrD7UqOwKCbWKg2KmgsQ/5KNH0x7ot+/bgMSbjVvOcRmmxQqZvkpGMuu9FU
         xJNOGbjNlvDpzAxa2xapAL2Tt5tFbrd1F7TlCU2MzlKu8+jHnJQ3bMOBAeLPhSflIqHm
         ukDkIDNGxit73rR/7XPp3j67sh0DVjH9yQ7PMgnnvTa/MTh98+jKDBqATtXky4DHzTTY
         J/OA==
X-Gm-Message-State: AOAM532kYzbCkip1hfkebN5IdZTzDrJGeD7DWEDodkNrzO7zl0MfcRxj
        Jb02004sEGgasn/CwGeIWvtVqVQswQk36IzqZryCAQuUQYSHdoWnoxCpErpzJPnUJxPRo4tXgx3
        3j3omc6wWQ/eZ9rJjkhdTBfy5
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr263794otq.179.1598645879654;
        Fri, 28 Aug 2020 13:17:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0nfNYShd/fLaNgYR9tr4qsn5gYzr5yuS0DTc5RPzbGI202F6TSa9iWZ9O85GKeYOjvc4HsA==
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr263783otq.179.1598645879392;
        Fri, 28 Aug 2020 13:17:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z13sm62938oia.30.2020.08.28.13.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 13:17:58 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] fpga manager: xilinx-spi: provide better
 diagnostics on programming failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200828195808.27975-1-luca@lucaceresoli.net>
 <20200828195808.27975-5-luca@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <20e0b1e3-938e-9020-a4b5-02e24692557d@redhat.com>
Date:   Fri, 28 Aug 2020 13:17:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200828195808.27975-5-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/28/20 12:58 PM, Luca Ceresoli wrote:
> When the DONE pin does not go high after programming to confirm programming
> success, the INIT_B pin provides some info on the reason. Use it if
> available to provide a more explanatory error message.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

This patch set looks good to me.

Thanks

Tom

Reviewed-by: Tom Rix <trix@redhat.com>


