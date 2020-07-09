Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2243207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IExuYAwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGIScB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGIScA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:32:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F2C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:32:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d194so1315311pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rDbdxwqrSb9n9LxA3TuonvCnzIU4pzGVQs1EJezV9vI=;
        b=IExuYAwJf/cXPpA4SudXZ2w5OHC3j3edAggaPx7e0vrrshwRPNirltfq0VxU2sVbGo
         5PpTHKlKcA9enS2c9LDWKkfI8cEHWDV/r02mawXgD9M7EMAmrbEck7XPauCSf4O8j+CL
         AW4AT58oGdMKRDmWGWReHya2rtULAFWLrrDs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rDbdxwqrSb9n9LxA3TuonvCnzIU4pzGVQs1EJezV9vI=;
        b=BDiamvJNOtObBKkTeMJLDpip+FtiW6DB1LoTZu2bdbkr8ptDA5uDLXiBc31J7x+CoV
         1wS6rE/H2YvL9HppdX7qvUgxBUs2pwmD4OFqZlQew4xnCJT+41T7O4Bc/9SpGsJJLOzV
         1VsZKKvhJbgPjaMpdI7D/Xgre6O5bFIzaKbfyv8/Dvg8iWOifc1BeDmQXbMHgM0BN/a5
         sAMY51lqU+XjNVzxjgGfnS1S7sQjET2VvEBj3mUoaLoVnFdSV/qnbb5gsRAcU7Fw2VK1
         I9R4s8eAD86P9TIazJ5uxDjZLY48nB7CpIThSIs6P+G0imcv/FuZqnFm6t1XfX4OX0gA
         vTNA==
X-Gm-Message-State: AOAM531b4LIwKgJFpMxlwsT/qInd4YuZ9mwf9VV//l6J9dHKKx+LSN05
        Jh5C/cXOV9RbFYXWB+w406GcqGN3PKE=
X-Google-Smtp-Source: ABdhPJzJke1hBySm6nQnsR1KYFItaH7Bi3pVqtBQ+hlsjXaYtFqhMsQAWVVD60S8zKKrp4LX6vl6kA==
X-Received: by 2002:a63:de4b:: with SMTP id y11mr31517390pgi.26.1594319520178;
        Thu, 09 Jul 2020 11:32:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm3560168pfp.7.2020.07.09.11.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:31:59 -0700 (PDT)
Date:   Thu, 9 Jul 2020 11:31:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: YAMA SECURITY MODULE
Message-ID: <202007091129.7D0E2534D2@keescook>
References: <20200708073346.13177-1-grandmaster@al2klimov.de>
 <202007080103.2DAD857D4C@keescook>
 <2c05c0c3-e72a-7cc6-3391-2e0d3bdf6b2c@al2klimov.de>
 <202007081531.085533FC5@keescook>
 <596fa9f8-954a-c452-2399-e063f4b04f57@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <596fa9f8-954a-c452-2399-e063f4b04f57@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 08:45:14AM +0200, Alexander A. Klimov wrote:
> And as it's the only URL here, of course the whole patch makes no sense
> anymore. If I'd replace the URL as you said, I'd make a *new patch* with a
> *new title* and just send it --in-reply-to here. And my statement "just
> forget [the old] patch" would still stand.

We must be talking past each other. The doc has 2 links. You suggested
changing one, I suggested also changing the other.

> Also IMAO in this particular case *I don't deserve* to be the author of the
> new patch as *you did all the work* for it – i.e. figured out the
> replacement URL.

That's fine -- I'm mainly interested in just getting the document
improved. I will send a v2...

-- 
Kees Cook
