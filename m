Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEC1C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A4A206E6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585447407;
	bh=KyWvyFXUNyC/dNJ7xFc6jf7kVLAzFXRG0s0WfHU3kpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hCBIY8yaWoa8aRTJRLv7mX4/SyhxMBJn101nfeZ5McJLtb9GyCnU7TjfoHa6s9tXy
	 +YtAcFYjlijvsVm/VwYav2X0WvlcX4mfqx4XY7VzP1Wf1zlQ2NWko0/plZqVMEgSdx
	 AdnrwctgwbvxUPIzFF0Qxvw/1YoYuR4pcIaumgzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgC2CDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 22:03:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39656 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgC2CDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 22:03:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id i20so14200846ljn.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 19:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u03hiLa6D6J07QDhydnufhNxwBtzijqVkMSzsbsgPcg=;
        b=as2skpujRBiJhR1RMukMPT2675gVAHBZWsQSLw9qUJMJpNQG0uIleCXAEq/ODLAvkn
         uXxbuTLQ5gmiQp9q9wpNSDladZo5zBu5miiIRmq8L7C/DkS+ij3f4UJpqpX4OMDQKEqw
         N8TiJk/pxJnaU+01UPLSpcIKLKQqxGW9b2h/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u03hiLa6D6J07QDhydnufhNxwBtzijqVkMSzsbsgPcg=;
        b=YW0zBsQqDatEPu62Pntb7COcaiadmJtmSk3/FdbjuKqKo/CVHxv63UnlXxrvo67UQ7
         DUci+poepHB/R47i3Keu2Oe/ic9P0pK5WGWjjLrjBD8USiFyaEX8LXWiHsv5Y3+krjD2
         o6a65DQUaG3QFaeOvlmsIAzQC+W6h78Cx6f+WsxMZ8ixNbbZagup6ZsdOlTRx9gDmZk5
         GLr2vHTrv8n3OdYGtnyuWAQb/vK9JpyZ7bgg1grTzu1/aLox6BbjFSNwJuBLBCw93nIi
         7naiKa68MpJAE2b6COTUMvHXMe7hs6VP0uw57+cC1TP9BbxbqPHrFff3AnvLQRAO6Sdf
         afYg==
X-Gm-Message-State: AGi0PubnXRA5aRyeuQpAaQwkOR/HC3JFGeTlgfMnfQMuV2IRmTvMxg6L
        iLjxNgXprbwoZY9N4L1Zo4J+Z7Ow9qg=
X-Google-Smtp-Source: APiQypIUTni3ewqSHnDiwO05rIvPIbq2XV5+fD8Cxi7JASijjkFhLO58Bc9f/yH2HYQPUGKc6CN69A==
X-Received: by 2002:a2e:91cc:: with SMTP id u12mr3726142ljg.244.1585447403440;
        Sat, 28 Mar 2020 19:03:23 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f28sm5286733lfh.10.2020.03.28.19.03.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 19:03:22 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id w1so14164318ljh.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 19:03:21 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr3401881ljp.241.1585447401666;
 Sat, 28 Mar 2020 19:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200328.183923.1567579026552407300.davem@davemloft.net>
In-Reply-To: <20200328.183923.1567579026552407300.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Mar 2020 19:03:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoySgT5q9L5E-Bwm_Lsn3w-bzL2SBji51WF8z4bk4SEQ@mail.gmail.com>
Message-ID: <CAHk-=wgoySgT5q9L5E-Bwm_Lsn3w-bzL2SBji51WF8z4bk4SEQ@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 6:39 PM David Miller <davem@davemloft.net> wrote:
>
> 1) Fix memory leak in vti6, from Torsten Hilbrich.
>
> 2) Fix double free in xfrm_policy_timer, from YueHaibing.
>
> 3) NL80211_ATTR_CHANNEL_WIDTH attribute is put with wrong type,
>    from Johannes Berg.
>
> 4) Wrong allocation failure check in qlcnic driver, from Xu Wang.
>
> 5) Get ks8851-ml IO operations right, for real this time, from
>    Marek Vasut.

Btw, your pull request information really leaves something to be desired.

You seem to have randomly picked one thing from each thing you merged
(eg that memory leak case from the merge from Steffen Klassert).

Hmm?

            Linus
