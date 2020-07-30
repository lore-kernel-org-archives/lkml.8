Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CAFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28132082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596103442;
	bh=eljX3hl3K/RgvgEJymDxfIjALfZUJgDGHliBMGzUt+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IxZQjYdd6qPnNxcFKGqEu275UAGc5rWGe2i7mUNkObZJeFL27m683W/Rjbza5+mrp
	 MfaeF0mPz9ikWXBbNBTOwZ9Mct1M1kTp1hnkzm5KP1D1UsUjUCiY0A3ZyoGzr8ULeV
	 nBODCiDA0Y5EzUqrfzuZlf3qq84pPFwpfpA/jdag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgG3KEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgG3KEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:04:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59DCB206F5;
        Thu, 30 Jul 2020 10:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596103439;
        bh=eljX3hl3K/RgvgEJymDxfIjALfZUJgDGHliBMGzUt+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUU9CgLCIvvZrtQtrr5LIYw3qBeezpEusGOnlllQEsJ+BV+N4PFvJr5knWU7czg1s
         aEPm6vxXQ5zm8pDvxg98tpXR3uZppmNX7KMfMl8sDZVA3qwgjVLnh7AMi6gS07Po7h
         tMUzIZ1Az54cJTa4hch/sOQsI0nrYOSUZgJ7dAk8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A40B40E57; Thu, 30 Jul 2020 07:03:57 -0300 (-03)
Date:   Thu, 30 Jul 2020 07:03:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        Li Bin <huawei.libin@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH -next] tools build: Check return value of fwrite_unlocked
 in jvmti_agent.c
Message-ID: <20200730100357.GD424218@kernel.org>
References: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
 <CAP-5=fX9YUucA-3QMxO_jV954104UPNg04=_JGstuLekNJHzJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX9YUucA-3QMxO_jV954104UPNg04=_JGstuLekNJHzJw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 29, 2020 at 04:47:36PM -0700, Ian Rogers escreveu:
> On Fri, Jul 24, 2020 at 3:07 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
> >
> > Function jvmti_write_code called by compiled_method_load_cb may return
> > error in using fwrite_unlocked, this failure should be captured and
> > warned.
> >
> > Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> > ---
> >  tools/perf/jvmti/jvmti_agent.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> > index 88108598d6e9..a1fe6aa16b6d 100644
> > --- a/tools/perf/jvmti/jvmti_agent.c
> > +++ b/tools/perf/jvmti/jvmti_agent.c
> > @@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
> >         struct jr_code_load rec;
> >         size_t sym_len;
> >         FILE *fp = agent;
> > -       int ret = -1;
> > +       int ret;
> >
> >         /* don't care about 0 length function, no samples */
> >         if (size == 0)
> > @@ -401,16 +401,23 @@ jvmti_write_code(void *agent, char const *sym,
> >         rec.code_index = code_generation++;
> >
> >         ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
> > -       fwrite_unlocked(sym, sym_len, 1, fp);
> > +       if (ret)
> > +               goto error;
> 
> Sorry, it seems I lost a reply to this. Won't ret here be the number
> of items written and not an error code? Consequently all writes will
> immediately goto error?

Yeah, I removed it from tmp.perf/core.

Wang, please address Ian review, and consider having just one out exit
label.

- Arnaldo
 
> Thanks,
> Ian
> 
> > +       ret = fwrite_unlocked(sym, sym_len, 1, fp);
> > +       if (ret)
> > +               goto error;
> >
> > -       if (code)
> > -               fwrite_unlocked(code, size, 1, fp);
> > +       if (code) {
> > +               ret = fwrite_unlocked(code, size, 1, fp);
> > +               if (ret)
> > +                       goto error;
> > +       }
> >
> >         funlockfile(fp);
> > -
> > -       ret = 0;
> > -
> > -       return ret;
> > +       return 0;
> > +error:
> > +       funlockfile(fp);
> > +       return -1;
> >  }
> >
> >  int
> > --
> > 2.17.1
> >

-- 

- Arnaldo
