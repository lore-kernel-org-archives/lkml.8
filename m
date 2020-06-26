Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E9EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FE820B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F6buymKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFZVo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:44:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC144C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:44:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h15so10802211wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1+9uR2cQTSLPsT8QyUR/Cg47J1BAdwHYi4CR0KpoXQ=;
        b=F6buymKASof8mmJbga47nan1aFNvRboyUdgZc2LDIhruRDLCx0xDwcGDnyyBHLgdEQ
         tL8z34BIPXnbhSA/4oerC5duMocRTSkhK9aPmuJ7yGiTAdUb9VBOO6lHWS6FN64ahzHe
         W2VZhmElm8ncvhvarmZFLuks3+pNBqAhih51FlGypS9QK2AZyPjXMwxQyX1tN/AI2fNU
         GE1v5T5+sOi9kxPv1j+ttF6DND7wxu0LEIpKVWLCxsnJHfDrlGJWjg4nz8LKN2KKd69M
         VCrG0mBPfLy/YOaip27jZ5ywmWERVt7hO8ZZZ46QIm0VhxoJmGkyyBlfx9Ku2oMWs4IQ
         9wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1+9uR2cQTSLPsT8QyUR/Cg47J1BAdwHYi4CR0KpoXQ=;
        b=WXO0nymLxSxjeAGlo2hlF//zRjOec+H+LMMenjWGfmFs0JH9DICtcCz8p8LPo9z9we
         /cU2Y/VOs3fQH2Nty2Qh8XkTF9dtGYvpTYOCeQaJ3iS/rZTsx57bAZ1tccVID0GogVXx
         1wrKdVFwigr8xG05KAeiExoMgQDrgY8lOgX8MTzKXOaVUXauJog0wkrYV3xsjobeGpdU
         gbstS0UNxw+MTnn9qgwhj8SLYgh8k9WIjIs5p1EcgbIC5LWSR2j8HpMvUqf15BEGbxlQ
         zBgxr6uIIiT35yKbm55WPx4Flk7fvV1z2bs8G7htTTOvz7QMK/O/FXbx1XNYTPFZDY1A
         tP2w==
X-Gm-Message-State: AOAM5304G5tyFn/b2t3R8xVr4TeOvcPsQKabs+4hoFx2ZYA28Rb8tybE
        VrQzVsNoF9hbTvPj+zDNMsbCMZcaApTmASxyCdvrTw==
X-Google-Smtp-Source: ABdhPJwFH8lMnF/e+eMJEtu1AUtXOMRtZMmfPI17iUqKjbKmM1h3+2EdvBGDRzYfZmEvupkBkmGNTFcHE5LC4mQv6Z8=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr5544449wrt.119.1593207865276;
 Fri, 26 Jun 2020 14:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626212522.GF818054@tassilo.jf.intel.com>
In-Reply-To: <20200626212522.GF818054@tassilo.jf.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 14:44:14 -0700
Message-ID: <CAP-5=fVMs4Ok3=gYmzheNTzbBUGGHbCr0cpJSm9TV45aeZb4Ng@mail.gmail.com>
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 2:25 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Fri, Jun 26, 2020 at 09:47:10PM +0200, Jiri Olsa wrote:
> > hi,
> > this patchset is adding the support to reused metric in another
> > metric. The metric needs to be referenced by 'metric:' prefix.
>
> Why is the prefix needed?
>
> Could just look it up without prefix.

The name could be a metric or an event, the logic for each is quite
different. You could look up an event and when it fails assume it was
a metric, but I like the simplicity of this approach. Maybe this
change could be adopted more widely with something like "perf stat -e
metric:IPC -a -I 1000" rather than the current "perf stat -M IPC -a -I
1000".

Thanks,
Ian

> -Andi
