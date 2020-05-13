Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8280CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355B720659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH57vh/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbgEMODS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbgEMODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:03:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D06C061A0C;
        Wed, 13 May 2020 07:03:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so14212775qtb.5;
        Wed, 13 May 2020 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3G6NbBH687PhEorC78hABjQaW3UsFMQBwTyJIw1H2/I=;
        b=SH57vh/sOIcptFApDczlfojRaN6agT0pZE3ZV9iMvKl8bM7q23eLJ8uMJBceitk6li
         Lh6vjsAB4mMkuXFPcptqbCUVIDeEPxfgziOZeDkkzQtxhcoMnp1GeeWlm5wP+iqMYT7E
         xDYj+Pim7kC7nnybV/fyXpqG3dKFluKiQViguzHrH8SRwfavN1m1KclS5T1u81yLNMCS
         eM1LtG24h+Fk5oul+xeCekaxzqdBx0VvUE8idtLs/wGibvypKjUI88QZqzHEUqb0xjhA
         IboDfMAJ8hixQ1MIdrDrUICySE6Ui2sE144r2/pdz4Ep5ceYy6Uiq18riYiPDBsOayTb
         Ahdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3G6NbBH687PhEorC78hABjQaW3UsFMQBwTyJIw1H2/I=;
        b=p1BoLz6JsEmmu+uDilcYvr8II2TjGfqUqdQvGq2fyxKiwoKRhsSRHPuL6aj5eoS1pz
         ipGNiACyBOikaj1EqJsV6IePrB6xkWjxaYfAN73WHHahdrZikHU4SOz1CFxZ7ZN42120
         AM1qC4FXYuIXUxNcKtl9xmoxC2ImEGf4XskSF1F1f0pStka/DDFS/1bGSIQs5I8MtH+3
         ROU8DZhSf26DE2D5mh1wzplyzpWan4qYQ5FiD8HYuuDp2z563l3qI+Zz59qKwFyAuk3U
         HNYMR071ub0p3Gl8adjU26uIqDojruh+gh26rWAGoT9MT60JQlYkuqqWSthVodPoaX+y
         WaAQ==
X-Gm-Message-State: AGi0PuYtIWkoIGhjETXHbL+r+chdxGV9HMroZzXIB3AtD0TrJQgoYOsY
        Tac5RaPsTh1k4pHxHxAgelg=
X-Google-Smtp-Source: APiQypKaX9YpHQRJDuptbqARxKoZsAwh4CSKzeiU89Q+j3KcLoPnLs5NuA9octTV0n8Kw/aH7pNrNQ==
X-Received: by 2002:ac8:544e:: with SMTP id d14mr28416241qtq.283.1589378592497;
        Wed, 13 May 2020 07:03:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id s125sm13898384qkh.51.2020.05.13.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 07:03:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BD6D40AFD; Wed, 13 May 2020 11:03:08 -0300 (-03)
Date:   Wed, 13 May 2020 11:03:08 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Anand K Mistry <amistry@google.com>,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf record: Use an eventfd to wakeup when done
Message-ID: <20200513140308.GF5583@kernel.org>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200513113941.GK3158213@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513113941.GK3158213@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 13, 2020 at 01:39:41PM +0200, Jiri Olsa escreveu:
> On Wed, May 13, 2020 at 12:20:23PM +1000, Anand K Mistry wrote:
> > The setting and checking of 'done' contains a rare race where the signal
> > handler setting 'done' is run after checking to break the loop, but
> > before waiting in evlist__poll(). In this case, the main loop won't wake
> > up until either another signal is sent, or the perf data fd causes a
> > wake up.
> > 
> > The following simple script can trigger this condition (but you might
> > need to run it for several hours):
> > for ((i = 0; i >= 0; i++)) ; do
> >   echo "Loop $i"
> >   delay=$(echo "scale=4; 0.1 * $RANDOM/32768" | bc)
> >   ./perf record -- sleep 30000000 >/dev/null&
> >   pid=$!
> >   sleep $delay
> >   kill -TERM $pid
> >   echo "PID $pid"
> >   wait $pid
> > done
> > 
> > At some point, the loop will stall. Adding logging, even though perf has
> > received the SIGTERM and set 'done = 1', perf will remain sleeping until
> > a second signal is sent.
> > 
> > Signed-off-by: Anand K Mistry <amistry@google.com>
> > 
> > ---
> > 
> > Changes in v3:
> > - Move done_fd creation to below session initialisation
> > - Close done_fd on exit
> > - Log errno when write(done_fd) fails
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
