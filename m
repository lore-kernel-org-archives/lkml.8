Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA16C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5F32082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KbnW8hcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgA3GbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 01:31:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40031 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgA3GbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:31:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so1109200pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 22:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc:user-agent:date;
        bh=0tFsYcjfOOa4j0wNofi5s1JbHK10UxRY/7iGvUSf+kk=;
        b=KbnW8hcVBL+cjoPJI4C8c4WYYBRdr3lVrJlK+VN35PtAz96+RJuL/ELLxdLSp0mLQr
         U9iIpV6CcuvgD2XX6SiYM16zJwlenQUU/44+VCqojADOc8i5f1SrK9zHJA1yIoDzcTsb
         JyPMx/3lnzwjm2LBn+HJSPUK6x2NxxcpNjT24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc
         :user-agent:date;
        bh=0tFsYcjfOOa4j0wNofi5s1JbHK10UxRY/7iGvUSf+kk=;
        b=sNUpLzSEX8zE8AJBSL3JL/BR4XhyBQmIFVceAJKi+BLtq9vymPYuJSaYVwiNcgJVhO
         0hxuJ6AKsHqC9qwPp/S8DFM6KHc2rzv2lGhQOV6RqQtFkkmlIguI+59nWFsnT5PpMTNs
         8WOsNhuX7UhTnTOIDbjfJ4MVLtgM8bNc1eZkWhuXMXUVEN1Zx4/LRt0TYi+mNOhK19ie
         9AzHMwZ/Zscy8Zoi5R8A0v7eE79T+fvnhNIdK9A16s8+Bj7ae74ZanX0sokEJCvYNLhZ
         MHDztgm1UGnL+jZZKqvjRmvbJxkJVSdw4VHBeiKmNNcSn+nysed0oQOT3VeoGshZB+S0
         0FOg==
X-Gm-Message-State: APjAAAXMrdnw8K1h38K8seapP0Gta3Uo/IcNZmlPeu+2c8UT5KdHBiO/
        p52EVCM6lUX6/yWKVi3+YsjKQw==
X-Google-Smtp-Source: APXvYqxkoOSz3EElUiJyrS7XLxT4E2RrTKPRQZsLo3gTD8kEkuzwObe1rg6ylHw8yiou5ZegP9TqoA==
X-Received: by 2002:a63:e911:: with SMTP id i17mr3199910pgh.42.1580365859422;
        Wed, 29 Jan 2020 22:30:59 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q12sm4862272pfh.158.2020.01.29.22.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 22:30:58 -0800 (PST)
Message-ID: <5e327822.1c69fb81.80136.dfc1@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202001271525.E6EB4FDD6@keescook>
References: <20200123160031.9853-1-saiprakash.ranjan@codeaurora.org> <202001271525.E6EB4FDD6@keescook>
Subject: Re: [PATCH] pstore: Fix printing of duplicate boot messages to console
To:     Kees Cook <keescook@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 29 Jan 2020 22:30:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kees Cook (2020-01-27 15:27:33)
> On Thu, Jan 23, 2020 at 09:30:31PM +0530, Sai Prakash Ranjan wrote:
> > Since commit f92b070f2dc8 ("printk: Do not miss new messages
> > when replaying the log"), CON_PRINTBUFFER flag causes the
> > duplicate boot messages to be printed on the console when
> > PSTORE_CONSOLE and earlycon (boot console) is enabled.
> > Pstore console registers to boot console when earlycon is
> > enabled during pstore_register_console as a part of ramoops
> > initialization in postcore_initcall and the printk core
> > checks for CON_PRINTBUFFER flag and replays the log buffer
> > to registered console (in this case pstore console which
> > just registered to boot console) causing duplicate messages
> > to be printed. Remove the CON_PRINTBUFFER flag from pstore
> > console since pstore is not concerned with the printing of
> > buffer to console but with writing of the buffer to the
> > backend.
>=20
> I agree this patch isn't the solution, but I'm trying to understand
> where better logic could be added. Is the issue that printk sees both
> earlycon and CON_PRINTBUFFER active? Can we add a new CON_* flag that
> means "not actually printing anything"? (Or maybe a new flag for
> non-printing to replace CON_PRINTBUFFER that lets pstore still work?)
>=20

This seems to be fixed by commit def97da13651 ("printk: fix
exclusive_console replaying"). I think there's nothing to do.

