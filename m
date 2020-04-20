Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05671C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A4720735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAWPWfc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgDTNa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726389AbgDTNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:30:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75979C061A0C;
        Mon, 20 Apr 2020 06:30:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o10so1814212pgb.6;
        Mon, 20 Apr 2020 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FFlSkMRcAhMtXPXTewG4f4dqL8kmUAL3zfykcT5xeQ8=;
        b=mAWPWfc/EH0Ir9h7bVjFcY1nyyYrt11a7uayBmd57IfjS7ljeKqAdVOKnQ8DqLva//
         7XxyiVEkovEyXPROCsKn2xjxV5v+HA6qmWZzp+eQDbEa977hKerQusxjfoxTYER6WXwk
         fuzOHclRQQDo8yNKu0mcotCzCYMunDK9P3jYbXMQyfUd9Fh/xrjtVDtgLIWDR0BFU6Dd
         grztPf8Qqt7k17SY/K9ywc8iArc7U475lLaO/AGf3xOj8RwIu6pTeY7whw9dlAoRcsfB
         7BkHYkIfwLynhkxpp+771EdgOdDhASt3IZSRhnc64GWxQSEpwEWyyiaI1sKbkotzu5cb
         CeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FFlSkMRcAhMtXPXTewG4f4dqL8kmUAL3zfykcT5xeQ8=;
        b=FUp4yqT0v2oTcumsMM6GVHL31k8bOry8gJTgBIdebZKO4OEauueDhjGQQrkfifiwO6
         dc2ov1DIIkS8Ip1P/MKj2uRF3bBGBksaJ7jBZnZ1GkNdIQAL2u0XR1GUSOZTy7UnXttj
         +IuNILDh6QzeEkFQnjDQsd0tcZ4TyCaBWWv2/tTEXzlt0NInnIhnprNJiYWIj5JQD48E
         QuiPKoRyz3aJ0hJmSO/0IDAovBrGEauoqZvIfVUjfAVmGaMS9uCuiYe8z7NRxCQteixX
         cKn24r5I960avb6Zclrq05zvyEXgltWNHWfTSX1MhvFCT+TraJpTOksO7duYa0mPfyYF
         poJA==
X-Gm-Message-State: AGi0PuZPlGwyPCJAOs+3Kng0l7jjNBVL6rIK+PSVkwSdGpufEnvsmy8h
        qe0TofLtkznGKvWj6hVQ9AmIlZZg
X-Google-Smtp-Source: APiQypIg/amfby2BJcy5FXvej/+kmd6kuERwpw+wJiX8y3W5EVXrWsTGtCddEqUpRUVv+jOObaPcSA==
X-Received: by 2002:a63:4c1:: with SMTP id 184mr16161358pge.156.1587389427069;
        Mon, 20 Apr 2020 06:30:27 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id y26sm1088884pfn.185.2020.04.20.06.30.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 06:30:26 -0700 (PDT)
Date:   Mon, 20 Apr 2020 21:30:23 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v1 1/2] regmap: redefined regmap_read_poll_timeout to
 simplify code
Message-ID: <20200420133023.GB8103@nuc8i5>
References: <3376dcba-4285-c894-915e-2f41cbf23caa@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3376dcba-4285-c894-915e-2f41cbf23caa@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 07:09:14PM +0200, Markus Elfring wrote:
> > use read_poll_timeout macro to redefined regmap_read_poll_timeout
> > and also remove the duplicate code.
> 
> How do you think about a wording variant like the following?
> 
>    Subject:
>    [PATCH 1/2] regmap: Simplify implementation of the regmap_read_poll_timeout() macro
> 
>    Change description:
>    Simplify the implementation of the macro “regmap_read_poll_timeout”
>    by using the macro “read_poll_timeout”.
>
Good, I will send the patch v2.
> 
> …
> > +++ b/include/linux/regmap.h
> …
> > @@ -122,26 +123,10 @@ struct reg_sequence {
> >   */
> >  #define regmap_read_poll_timeout(map, addr, val, cond, sleep_us, timeout_us) \
> >  ({ \
> …
> > +	int __ret, __tmp; \
> > +	__tmp = read_poll_timeout(regmap_read, __ret, __ret || (cond), \
> > +			sleep_us, timeout_us, false, (map), (addr), &(val)); \
> > +	__ret ?: __tmp; \
> >  })
> 
> * Can this macro work also with variable names which do not contain
>   double underscores?
>
Yes, this is to avoid using the same variable with its caller.

> * Can the tag “Fixes” be relevant for such an adjustment?
>
I think It is not relevant and we don't need add it.

BR,
Dejin

> Regards,
> Markus
