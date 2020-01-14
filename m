Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB825C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8377124658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwFSajBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgANRpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:45:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44448 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANRpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:45:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id t3so13178334qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 09:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bSbYINgLeggmemXakNXY6Lds7dtXO8DS5WuVbPr87Do=;
        b=NwFSajBZpCOhpH7gWbhcAMnYMKeb1ESUiK3HPUvfz5TxonX+BsfdxZU/m9opnmErkE
         nv9+KO6Og9Nbe5pW6ja9MCUxzm4jjnnoRQP+fzBUpNM2k59xwSmJs3QZpWRxABGdBd2m
         Yzg7tkGo8eBMLfOYyACNxd1npxnvt7Aof0XzFA8ImnDeyXpna21AHlpCVEddZFEZJVK2
         vk2CihaIVju0ppPNSph+t6kn3S2JRpxqp3vOOeNcUpY8uNQXEpYA9+qaB/PpLzsdNy1K
         l8wWk23QtBPBFdYQjh0RNy/EHK/M7Kw07j0ETRbwDUpY9XtJourBynrqfpB2Ku7mT1SQ
         URZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bSbYINgLeggmemXakNXY6Lds7dtXO8DS5WuVbPr87Do=;
        b=FP7QNWP43ZLzFMNAM0MBjfqpkVQg6eaAEnqsMBrmmr/yn9gU3r6SAd96OuybWL0YMZ
         1iDIZBO7Zr/fY/ilT4zRwEj04U5GHJD3te2GahAh4S3GHmhyZ7Amur6uQLm08DmShUZu
         jynAsAuKKS6UNpfvo8718fv5iQ3F6LFxBQsF+wR5PgSFOmHzSB+UXrAIruhlpbQVYftU
         yunHlzVJ5oWmVJBphXeOVT3OcHv9vqhZDxMPQ2ZjnTYF4gM6dYmcETZZr3/CoOl/wskB
         J2a/ewrvTZVe7jD99AI20XI/dfMsp8X3Vx4fVrv57rzSWhACXyCkEO4vgPA4/YZyIwEu
         RMjQ==
X-Gm-Message-State: APjAAAVUxcDaJWbN+VdPBADvNTUfv23wgzvKbP9kLwvHuvhAOzqO8aA5
        VdnwIEvzw2Mn9R+xz086T1Q=
X-Google-Smtp-Source: APXvYqx4aMV7wAvhz4OF1apRnJSsisB/0qjF5O3QUnwsJY6MXBYkMP0f5Dv2+YZtcIrhpbTHyiZFuA==
X-Received: by 2002:ac8:5206:: with SMTP id r6mr4475585qtn.214.1579023906199;
        Tue, 14 Jan 2020 09:45:06 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c13sm6999572qko.87.2020.01.14.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:45:05 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A7BC440DFD; Tue, 14 Jan 2020 14:45:03 -0300 (-03)
Date:   Tue, 14 Jan 2020 14:45:03 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,
        Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/uprobe: Fix double perf_event linking on
 multiprobe uprobe
Message-ID: <20200114174503.GB4769@kernel.org>
References: <157862073931.1800.3800576241181489174.stgit@devnote2>
 <20200114173535.GA4769@kernel.org>
 <20200114124404.50a1c396@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114124404.50a1c396@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 14, 2020 at 12:44:04PM -0500, Steven Rostedt escreveu:
> On Tue, 14 Jan 2020 14:35:35 -0300
> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> 
> > If you don't mind I can put it into my next perf/urgent pull req to
> > Ingo/Thomas,
> 
> I was going to pull this into my urgent tree when my tests finish with
> my for-next code.
> 
> I have one or two other patches I need to apply to urgent as well, so
> it's not an issue for me to take this.

Go ahead, I still need some more time for my tests with the other
patches, please just collect my Tested-by,

Thanks,

- Arnaldo
