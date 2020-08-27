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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC6B20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/Qft8ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgH0TEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:04:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726894AbgH0TE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598555068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpPTnyY1jEEF6hodFsVeyGCg6LIEq1osNtlESX3XqhY=;
        b=g/Qft8neV0uKsCdaMRaqfrQirXbLqXr53QmqyfR0TXWXcd8pwHYrVENSTg8fAuFM24VaM1
        kyxwqneKcvaX7M6SiwSsG1AtX+6sqO/gZ/J7hHdh8MXWm8J9LS234jmYFnyrMMYj3qfXZP
        XMLtL4xmn2vYiZEEWOzMcf+/ofyT5gw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-oZ592Wq2PDC-_supR5WPqg-1; Thu, 27 Aug 2020 15:04:26 -0400
X-MC-Unique: oZ592Wq2PDC-_supR5WPqg-1
Received: by mail-qv1-f71.google.com with SMTP id e12so3435295qvy.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dpPTnyY1jEEF6hodFsVeyGCg6LIEq1osNtlESX3XqhY=;
        b=o3b+qqgl7PZ+OFm5zOYBvbSOYi3UWNt3iCZRP1ccPKZ6cfK9SAIANuPjfP2j/Ki5+E
         FYqcqRclwdk+QW0mahMQovl8B/ujJjOM7Objc+S0iwhw785+929fgLLoV6l4h8CuJ/bw
         BgGus8MkfiF0dO7+0eTZEMHB8ZiUglcHf4+EaU65oq+w6UG5yvoOUf2XFnS1M61Uo5HR
         mcWNWA41lW3kndS3gzcjKKk5dUFNXtZBWt6siWuSXymGR0LojsVLa6Xnmhl6cTjEauJy
         NEUCurAfnUry6Zqe/4DTbDwpZ5tkvDL1qFRjCASg9RlIoFw83R0fsbeQ+84QX+byA2y2
         5Mlg==
X-Gm-Message-State: AOAM530+OWtqQgKsF4nWe4z0C4p+qPWbtSQ/77+q1VnlQuOc92lgznLW
        +Wm1Ud0JWD8evQHkZ0YbDf28/cGOeIO6+CWea7/UqwZkT63ipDjqp/I+e+JWmJW9KlDLneXBYV5
        Zi5juB1WWt9M7PiOibEa9qaOS
X-Received: by 2002:ae9:e40c:: with SMTP id q12mr17555684qkc.68.1598555065940;
        Thu, 27 Aug 2020 12:04:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwu1wIJxuc9erShjjxOxlzaZkchq1wagQLHXczQWn9FAGBbene5P6362g6/5YgQY916BkKSw==
X-Received: by 2002:ae9:e40c:: with SMTP id q12mr17555673qkc.68.1598555065747;
        Thu, 27 Aug 2020 12:04:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w20sm2464189qki.108.2020.08.27.12.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 12:04:25 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] fpga manager: xilinx-spi: add error checking after
 gpiod_get_value()
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200827143249.10973-1-luca@lucaceresoli.net>
 <20200827143249.10973-4-luca@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e0ce7edb-53dd-2961-278d-e9bc8a1726ac@redhat.com>
Date:   Thu, 27 Aug 2020 12:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827143249.10973-4-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/27/20 7:32 AM, Luca Ceresoli wrote:
> Current code calls gpiod_get_value() without error checking. Should the
> GPIO controller fail, execution would continue without any error message.
>
> Fix by checking for negative error values.
>
> Reported-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>
> ---

Thanks, this looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


