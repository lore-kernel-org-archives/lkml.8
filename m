Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18FEC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE92207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIfBQrxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgH0TJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:09:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48636 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726858AbgH0TJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598555348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAEZo/YE9GEddiVed/r0hHvLBr62Nk6jQkAItPMa1zw=;
        b=UIfBQrxMXqA4B85wcBiH/4ozRF4L7hC2+Q8HKKy7R7r9IepLH8Qzll0WERa7ldMwXl1TTP
        9jQ42xJSho2QbF0OpqfqFlT9WKgWF7nw9ORkhZh2mIIRwdrfoF/HJEH4atNYTQCLOHZGA6
        Wlbh6IEmiRmNwv3ISrC497/kJ5yNsh8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-LJo2yTJ8NXmVnFLIxPaUAg-1; Thu, 27 Aug 2020 15:09:06 -0400
X-MC-Unique: LJo2yTJ8NXmVnFLIxPaUAg-1
Received: by mail-qv1-f69.google.com with SMTP id k17so5362647qvj.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KAEZo/YE9GEddiVed/r0hHvLBr62Nk6jQkAItPMa1zw=;
        b=bYTGcYwN1SVFR9Dqc896sjpRblw39JTiU/SIeib9Qi8tcvWKJ6IykvxIjs/XP4uXjk
         EWhFbstbED2gVsir1oS6rF+XX9lgeUSNqg2+EEKbCb9fpPqWGdjaC26Rf22Qs1SYizj8
         I6tBW8Hu71nQfHMX65je7Ks+Xh3MxwTe//GOyTPla3KaNLyicpaKW+QZOYex7TNR5KqS
         O3KQZIDWN1aijT3k6AlKKIaxjKuyQIUiGXneAHaCjIjh8Cn1r3NoQFwxS4BrSU4qo8dA
         rDDLNwKxQholnTBkcUZCzWX9cAuux+XEtj37YwQc7Zy8TwrV9X52IRBL7HSN+d+kZK5H
         N8+Q==
X-Gm-Message-State: AOAM530SKOA2fKopu5+uzi/PDA2BMc41cEjJ+tjiErpbbykArPwVmGk4
        YkU3VTjZ36D5r8F6hKaU8EP3JEjvZ8EK/3oxYaCuij9nMEL+b7ynA8fmyxEB1KR3lpXYRhWksGA
        4/oeSmI76u2EcpjZQZ58FQg0a
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr20257279qtr.1.1598555345821;
        Thu, 27 Aug 2020 12:09:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuHQT71lwx6nYLk2qBAQLkclZ4rkI4WcjiaeOHy8y0S6Fv5A6mtp3yabGqDWLQs3wAdEI9YA==
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr20257253qtr.1.1598555345605;
        Thu, 27 Aug 2020 12:09:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 7sm2553032qkp.57.2020.08.27.12.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 12:09:05 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] fpga manager: xilinx-spi: provide better
 diagnostics on programming failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200827143249.10973-1-luca@lucaceresoli.net>
 <20200827143249.10973-5-luca@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <aa201535-a5f6-04b1-1444-35b68ed47281@redhat.com>
Date:   Thu, 27 Aug 2020 12:09:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827143249.10973-5-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/27/20 7:32 AM, Luca Ceresoli wrote:
> When the DONE pin does not go high after programming to confirm programming
> success, the INIT_B pin provides some info on the reason. Use it if
> available to provide a more explanatory error message.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>
> ---
>
> Changes in v2:
>  - also check for gpiod_get_value() errors (Tom Rix)

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


