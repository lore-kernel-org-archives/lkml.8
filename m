Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973A8C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8342084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1hD4yeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBZJwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:52:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32928 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBZJwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:52:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so3039432edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oo/wjk0TgsxSlzI7tb59Kc+WtD3z+3CMs//fzq8EQR4=;
        b=Q1hD4yeHtrVw8LeGw9dWuofl00qTg9dx68/nGk0DKtoLBaX0ZncZEpcN0G3J0XBg2D
         VQdcIWxtWtsmAt4z852Z/xHz+v9FE5uMgLTqKRSg6qYbQGwcYJAStv2vwAYy0ADpxa+x
         3BUw3Quxpu2w95Q7IoSiXbgY+yvFrMPzhw9rheFRfxWkMolcIa0qhrgfV+Usw1uA+fPG
         rurY4C2Psq/35xTeqLdLdRbtLktGDNPi8WJExrRBb98JmMu6Rof6xCIClM8jd4QlrhfZ
         SdofLEazMgBNL8egFoOaPet0oVZGPbvhOriC9Nfpc0V/tjkEphqHQL2jYNNDkSDZm2fU
         ryZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oo/wjk0TgsxSlzI7tb59Kc+WtD3z+3CMs//fzq8EQR4=;
        b=jwoptA8c0CdQaP1HBMiWqLeSCe7IRwqcgobyurRXfchcnqpCBF/ANTco8LZUEv/X4o
         RBYIKvAg/tjBBF/tSIqUUhfNVVHrWfFe+DkauOnjYRLDmu/xPpXQkrnofiEWQZ77QNEy
         z2dDEk3mvzDWSu5jgxkVoCOz6Dqp41Z4MwOjssKDnxwDP2TPXqm2iFgW30gniqAZlHpd
         8lQptyr7GXMwlfXUij4/3LJRBWDrFmLNtwHfLmKZa5tc4yLntclQogsnZIOQMpW4e0r1
         rXBV7NNCVyrWN/hhTbaVcaktM9/H5sF/lMaIhdC1bMTM6oO85L9BfI8p8OI8NZ8AET3l
         Ljqw==
X-Gm-Message-State: APjAAAUzUNG4FsFKiV66XOZsJUqBDNN+q1tPIxq1br+y1mUT3BHLqtUa
        fYZLb5id6XBMRW1dQX+UqfQ7a0SolRMlToWfhYo3og==
X-Google-Smtp-Source: APXvYqzjJas0LBloNdKHaQsC8EZooHQjrgYlqEEuaUfn+N2Uz5Zq3SdafXNY2fG8n4xsO+CkP2nevxD3Fk69WgXiic0=
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr3786223eje.276.1582710756748;
 Wed, 26 Feb 2020 01:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20200226023027.218365-1-lrizzo@google.com> <20200226081048.GC22801@kroah.com>
In-Reply-To: <20200226081048.GC22801@kroah.com>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Wed, 26 Feb 2020 01:52:25 -0800
Message-ID: <CAMOZA0+4Qg+bDQ1xGQ0jL=dvXK80LuxOa7tEd-=iBwat2M9pfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] quickstats, kernel sample collector
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        akpm@linux-foundation.org, naveen.n.rao@linux.ibm.com,
        ardb@kernel.org, Luigi Rizzo <rizzo@iet.unipi.it>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:10 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 25, 2020 at 06:30:25PM -0800, Luigi Rizzo wrote:
> > This patchset introduces a small library to collect per-cpu samples and
> > accumulate distributions to be exported through debugfs.
>
> Shouldn't this be part of the tracing infrastructure instead of being
> "stand-alone"?

That's an option. My reasoning for making it standalone was that
there are no dependencies in the (trivial) collection/aggregation part,
so that code might conveniently replace/extend existing snippets of
code that collect distributions in ad-hoc and perhaps suboptimal ways.

cheers
luigi
