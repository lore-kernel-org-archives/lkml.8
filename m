Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41964C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0F42075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QEoArzwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgHTWPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgHTWPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:15:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7D8C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:15:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a5so67270ybh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OgYs9wBAi2Q8Z6LQ8VFTN49js9Ku6BxLyyZ6fl41960=;
        b=QEoArzwvR+keZ04tkQufOOqw0ITVRrgGbXT4uCwgy63/lct2ed/SA0VxCn0/Q1iDHH
         z02MWgaoX8OZprP2rZMmNLXASg+VivCif6rXAlbSUPcOL85oZXAhIWAtgiJNOZAirlSI
         XEV9S0zCGnMwex7tR9pUvHZsDlJY7Vm1QOdiax3QbTh89UPBdWb8bABmqP7NiO5tIi/2
         7CVbGwFiPLMCHL+/STNLYuqH6yo1skOTg9mwz+iL5pa/ZBtdiF5Pm/3vwfQ9ugd5hU0l
         tX0TuubHeaI+suUj2OYVcjLCm7Sintyadxy59WAtLcuCvmjV3MQMJ/7M/hmg4B/1rR47
         dg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OgYs9wBAi2Q8Z6LQ8VFTN49js9Ku6BxLyyZ6fl41960=;
        b=Hq5AHUA5qR6mDNZw2Tf7S1R0DF1m9/+B2efmnwYlUMDhmvyvGEyjW7lbb5/zmwJlud
         wKjsfUl4m8zAftZ4ut8RxSF1nYT/AvG0qh+vZsv1frtYBMcEdB0BbkUjD4AIm93CXtEF
         tjk15WytZKgxjzSBezS0hLMZbv0jKDsOmww5+nmmgzHhS5fpeDsXyD4AodOC5K24rH/j
         TdVdRAiq82pqGcrvlcDM/icvtWyAHfVAgyBqIHuMgs0RgSXN96Yw/hsa+5W1CLFBKs9i
         1nZaC+LmuT296CmLgEYI3fHo0/a4fapNfFZn9+m81oL+K13scG+VPvJ5jrDtjkwx9hYh
         BaFQ==
X-Gm-Message-State: AOAM530qNp3DWfkJAnR/JPnS4fbG5mMmzXpCtJkv6WOHuFsQAHMEh3gL
        WPaUiep8Kcdl+rDF/sxVjNMLpbXZ4kcoECNJCgE=
X-Google-Smtp-Source: ABdhPJwrQHhcev82v0OvQB5LIkA0v24fBLk+zmR4VkXOBWeYV9BoAPV6klJj5Yskh2J7PX3O4fV5WvAB4IQTcZccN4M=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:6c86:: with SMTP id
 h128mr491840ybc.115.1597961712598; Thu, 20 Aug 2020 15:15:12 -0700 (PDT)
Date:   Thu, 20 Aug 2020 15:15:11 -0700
In-Reply-To: <20200820220210.GA14894@embeddedor>
Message-Id: <20200820221511.3328330-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200820220210.GA14894@embeddedor>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: Re: fallthrough pseudo-keyword macro conversions for 5.9-rc2
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     gustavoars@kernel.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, clang-built-linux@googlegroups.com,
        natechancellor@gmail.com, miguel.ojeda.sandonis@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gustavo,
Just noticed this on lore.  I'm curious if you'd had a chance to test your PR
with e2079e93f562c reverted?
~Nick
