Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9900C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D6B2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P+rBwBwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbgAQC7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 21:59:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44250 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389015AbgAQC7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:59:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so10908891pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 18:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WTJDQFAFgGa6rVA6Vls+B5d28T5A6XlmnE+ynC7RqWg=;
        b=P+rBwBwh3nYihg8kJTLr1bcuK7nKVCFuRWmXjcgoKle43XZswMOHTvDAMl2MxzVMwK
         fNitoQqWekzXfyYNFbeKHQaUgQw1fYvA1CqNqa8ICJXYH8cgzX13KOySiKOPOg1a++km
         JS635mIgS+7FehmcH36CcfND80cPEwC4TaOh4YVn+jVfEac3+LOoGDKqqjZRIUh+IhCS
         GeYsAdzbomNobynrJNgmCEd3UH4PX3CNz+O67LeelHN/14Osz9WDJGu8gg/sdZCZO3n7
         gH+t9jA8wut7XqYqvaDH3kVS8v0m2x0nID40hEODj2v0OdRfWJhx5uN/T/wO9h9iqHbT
         1OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTJDQFAFgGa6rVA6Vls+B5d28T5A6XlmnE+ynC7RqWg=;
        b=YOu0sdEy0kf9bqmIcVJ/AxQUnTY3D6mYiKMH58KNy8CSKyX2zc7SgFsfjZU+w8BS1h
         SKQLI87nfdzmjUHI/EnGeiP7DLgKtUrO0QCPzbpRE6tkeQKLQsAjHRkrq+r1nZpaoOcN
         f0NUX6l2UI7fHRtrniJdZJN8SSS/30hrL+PpiVrA/5YezukSx7/jO9y5E03yZUxZ/akO
         ad4WUyY5nvFNJGURjdoDoICyIQG6bzC9g3JzoUj2WXMI8GhJw7lcUy9DcCoFNcrD37EN
         Dese2zuCpfQoWDEAgYqJvnXGfuo/G0bVt/SM7nv9BO4HEkm5IXrcrcNp0Ao+Ix/oIKG3
         XPgQ==
X-Gm-Message-State: APjAAAVA6P607MLPbuX1Y13VY+dp3s+nqHS7GTzGQukhb+yxYl8WGgD4
        bhYHZtblomggclUJLepSI+x3eA/Jr8gdLg==
X-Google-Smtp-Source: APXvYqxwQvjW56vsm7+bcdf0FFq6XYFyxl6OLg3QZhIlw0/lBGJJTvXkfrA8zaPvLPzQ4awtN8JMgQ==
X-Received: by 2002:a63:2d44:: with SMTP id t65mr45222695pgt.112.1579229959940;
        Thu, 16 Jan 2020 18:59:19 -0800 (PST)
Received: from ?IPv6:2600:380:4b14:d397:f0a3:4fc6:c904:323a? ([2600:380:4b14:d397:f0a3:4fc6:c904:323a])
        by smtp.gmail.com with ESMTPSA id j7sm28891872pgn.0.2020.01.16.18.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 18:59:19 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: optimise use of ctx->drain_next
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <6063bf6baa6fa1f5ec45272eb7c0b428698ded7f.1579222634.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b3d3147-260a-8649-c99b-681624762334@kernel.dk>
Date:   Thu, 16 Jan 2020 19:59:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6063bf6baa6fa1f5ec45272eb7c0b428698ded7f.1579222634.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 5:57 PM, Pavel Begunkov wrote:
> Move setting ctx->drain_next to the only place it could be set, when it
> got linked non-head requests. The same for checking it, it's interesting
> only for a head of a link or a non-linked request.
> 
> No functional changes here. This removes some code from the common path
> and also removes REQ_F_DRAIN_LINK flag, as it doesn't need it anymore.

Applied, thanks.

-- 
Jens Axboe

