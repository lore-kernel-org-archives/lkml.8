Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D69206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpUfTauQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgEKQVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgEKQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:21:13 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43137C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:21:13 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id v5so4912170ybh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIvYQf7+HkPJXF+hLzvsrOFOyym3PIWkrBrNtFo1Fws=;
        b=ZpUfTauQEdSZlM5MU4B1FmbS5bSC5NWKY8XrLbs0L8nNYjucS3yZs6FqZsseAdNky0
         pzTc/lHXb69MryUouePkiALwHunbGM2/hJPYdfvoJn5Kf0bSlrOIO0VcxmMpdtWIfFot
         Xhv+drD78LRFgHfloGaGsW8ua41ZldwJsCIZjX/7rsZxmJVGIO7imCVigrotlvNG24pH
         B+KfmDVf6VwFe+jZDGa2kQFXEmkY7bFDjojGA178OB1r8UHO79p1nI1EcOYle18q8xXO
         cg0OwquKZaIhnXz4XYH4YctjtI33QgzWG+2kq+bFT1+mFwaGjTUT3dy6rA9/6DBWHzhB
         JuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIvYQf7+HkPJXF+hLzvsrOFOyym3PIWkrBrNtFo1Fws=;
        b=po2XbK0ZbrS/y8IoNmRuW2asKZwzPr/JTuM3A8jYH9A/9VYk18Eeacxysv7F+gwhGL
         GuaoSqJEeKBk3v6oHJ0xnI6RRIIX7s6SMMOuWxmaFYxjJp4C82qFEiCu3HmnOJkoSALy
         lCeSfs9YvgNI02nxp5IB9S2STUDAVJfT1t5NekJEAzmBZ9FDuJ2P6ekwEYEz4rKmi6s0
         NesPlYp2NI9G25tOuS5f6GDuXmyZ+658g5LRSSI3AtL/rLCx2mMaw1f23IcQxhgHQFqc
         UNrTzaG6Q+R+HrF9SIAVQtjRYN74niTCHyE5ka5g+kKJ4/4GGJLdF4tIfR2hfMyHayRW
         qkzg==
X-Gm-Message-State: AGi0PuYkoFY5JMdchb4MF5q+y64885sZ4+LfV8Kitf9f12iN12l84Wg6
        CIiv47X+wlpUVMy4ws5X/gyPwxQ/Dy2l9vuEHdWnaQ==
X-Google-Smtp-Source: APiQypJDS4Ig3fLtht3np8evh8Ahm25jLEUMg+mChgwDxkFitWkfwAlXSox5L836eKJkVNb3xgmu/iWT+RSDRn2K2j8=
X-Received: by 2002:a25:5387:: with SMTP id h129mr24914557ybb.47.1589214072246;
 Mon, 11 May 2020 09:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <1588852671-61996-3-git-send-email-john.garry@huawei.com> <20200511110137.GC2986380@krava>
 <9f4ea413-325f-98b4-eb4c-e47aead4f455@huawei.com>
In-Reply-To: <9f4ea413-325f-98b4-eb4c-e47aead4f455@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 May 2020 09:21:00 -0700
Message-ID: <CAP-5=fWHipkL6Uq1vMaz-51ETPWajofDXd6RTBMr00pcyooo_g@mail.gmail.com>
Subject: Re: [PATCH RFC v3 02/12] perf jevents: Add support for system events tables
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        Andi Kleen <ak@linux.intel.com>, linuxarm@huawei.com,
        LKML <linux-kernel@vger.kernel.org>, qiangqing.zhang@nxp.com,
        robin.murphy@arm.com, zhangshaokun@hisilicon.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 8:03 AM John Garry <john.garry@huawei.com> wrote:
>
> On 11/05/2020 12:01, Jiri Olsa wrote:
> > On Thu, May 07, 2020 at 07:57:41PM +0800, John Garry wrote:
> >
> > SNIP
> >
> >> +                                  &sys_event_tables);
> >> +            }
> >> +
> >>              print_events_table_prefix(eventsfp, tblname);
> >>              return 0;
> >>      }
> >> @@ -1180,7 +1253,6 @@ int main(int argc, char *argv[])
> >>      } else if (rc < 0) {
> >>              /* Make build fail */
> >>              fclose(eventsfp);
> >> -            free_arch_std_events();
> >>              ret = 1;
> >>              goto out_free_mapfile;
> >>      } else if (rc) {
> >> @@ -1206,27 +1278,31 @@ int main(int argc, char *argv[])
> >>      if (close_table)
> >>              print_events_table_suffix(eventsfp);
> >>
> >> -    if (!mapfile) {
> >> -            pr_info("%s: No CPU->JSON mapping?\n", prog);
> >> -            goto empty_map;
> >> +    if (mapfile) {
> >> +            if (process_mapfile(eventsfp, mapfile)) {
> >> +                    pr_err("%s: Error processing mapfile %s\n", prog,
> >> +                           mapfile);
> >> +                    /* Make build fail */
> >> +                    fclose(eventsfp);
> >> +                    ret = 1;
> >> +            }
> >> +    } else {
> >> +            pr_err("%s: No CPU->JSON mapping?\n", prog);
> >
> > shouldn't we jump to empty_map in here? there still needs to be a
> > mapfile, right?
>
> In theory we could only support sys events :)
>
> But I'll now make this a (empty map) failure case. And I think that
> another error case handling needs fixing in my patch.
>
>
> As for this:
>
>   +     fprintf(outfp, "struct pmu_sys_events pmu_sys_event_tables[] = {");
>  >> +
>  >> +   list_for_each_entry(sys_event_table, &sys_event_tables, list) {
>  >> +           fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t},",
>  >> +                   sys_event_table->name);
>  >> +   }
>  >> +   fprintf(outfp, "\n\t{\n\t\t.table = 0\n\t},");
>  >
>  > this will add extra tabs:
>  >
>  >          {
>  >                  .table = 0
>  >          },
>  >
>  > while the rest of the file starts items without any indent
>  >
>
> I'll ensure the indent is the same.
>
> BTW, is there anything to be said for removing the empty map feature
> (and always breaking the perf build instead)? I guess that it was just
> an early feature for dealing with unstable JSONs.

+1
I'd very much like it if JSON parse errors and the like didn't result
in an empty map but failed the build. I think ideally we could also
validate metric expressions using expr.y. If we include expr.y into
jevents then is there any need to parse the metric expression at
runtime? Could we just generate C code from jevents with a list of
events (aka ids) for programming and a dedicated print function for
each metric. The events would still be symbolic and checked at
runtime, but the expressions being C code could yield compile time
errors.

Thanks,
Ian

> Thanks,
> john
>
> >
> > jirka
> >
> >>      }
> >>
> >> -    if (process_mapfile(eventsfp, mapfile)) {
> >> -            pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
> >> -            /* Make build fail */
> >> +    if (process_system_event_tables(eventsfp)) {
> >>              fclose(eventsfp);
> >> -            free_arch_std_events();
> >>              ret = 1;
> >>      }
> >>
> >> -
> >>      goto out_free_mapfile;
> >>
> >>   empty_map:
> >>      fclose(eventsfp);
> >>      create_empty_mapping(output_file);
> >> -    free_arch_std_events();
> >>   out_free_mapfile:
> >> +    free_arch_std_events();
> >> +    free_sys_event_tables();
> >>      free(mapfile);
> >>      return ret;
> >>   }
> >
> > SNIP
> >
> > .
> >
>
