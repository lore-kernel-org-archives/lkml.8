Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB267C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F192074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khnySYO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCMW7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:59:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33952 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMW7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:59:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id i19so9218026lfl.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 15:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWS5+OO45KCQA5QZcdbsnGmNQp6lkquwGjGiNv3JKdc=;
        b=khnySYO5WT1cMupKaoHzf9IZWc4QaM2lpqEdF+qwWmzriNscqK+yj6geYC3zyZz1yX
         eYvcxPyIqm2CkjaMV0npdrtMNaGmMxppzqrHlBhWBGqOn8jvhj6QcLe640EKzAeKCKy6
         QUMRttpypFL1KkKTr+zJkUsennbvBepBwtSTCt5nyVus4AF0Do/3rpuf/L74ypfeMXeP
         AOVKJVPkUATBwAWlR41/YBv+WGrGtuE9alu1Lsgc2zQh+ThPiO6RiM+tVQtRkgGQHB5w
         ZGDXYle2IcDAzxoHToMj//L1/yGQCqCYmOtRkTLYXJNG1g1cppIL/9bZvID4RqBWIFXv
         TemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWS5+OO45KCQA5QZcdbsnGmNQp6lkquwGjGiNv3JKdc=;
        b=tXDfxigUSw/gV4Pn0fcyfPmX70KGH8Mpwne0xwkyuyomYjl6/8NynyMmYV0GVTDzgo
         9dHy0jH+FcFFJZbqOm+FGlI4TtmS5DAvuaTtYcbWzimTjDIE2WlUUT+yqyTY6AEmbyn8
         TpEuWsV76qIr+zUdEYH0TAPVjIKB864g1VO+whkp1mI3/Ga9oCnECF2aeVRSYjTQwpPq
         PrlA3KUJI2GMEGVq+hMlgNWGk/r8Pqh8iw30hBllTrObj2aV9xFe8gQvg+knj7LI/yXj
         rIBekGeIXiBhIsS6UHgjCPX1T/IAn0UAvoLFPnjhcM9I0G+xPKnTTFVIgLb5cpG2tf8i
         /miQ==
X-Gm-Message-State: ANhLgQ1kxSMDPC95bYiCMFQF90sBEdY5h5py3ibgkBWqxkKZM19P7pMF
        ZSTWl0DFQL0xzyRdsa6qJgoxOgjRYwEw52rIblaD
X-Google-Smtp-Source: ADFU+vv8q3Bmu7rpYOUbo3wmyVU8hXCXnpf62lwEBTwRg1ToKZ1AfJqrXdIt/3KcZpky7g7yjeEsJ1m2/Jrl9SGeIz4=
X-Received: by 2002:ac2:43ce:: with SMTP id u14mr9872354lfl.100.1584140388874;
 Fri, 13 Mar 2020 15:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
 <20200302235044.59163-1-zzyiwei@google.com> <20200303090703.32b2ad68@gandalf.local.home>
 <20200303141505.GA3405@kroah.com> <20200303093104.260b1946@gandalf.local.home>
 <20200303155639.GA437469@kroah.com>
In-Reply-To: <20200303155639.GA437469@kroah.com>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Fri, 13 Mar 2020 15:59:37 -0700
Message-ID: <CAKT=dDnT_d-C2jfcgD+OFvJ=vkqxvQDmg3nAErvs9tXS6iifpw@mail.gmail.com>
Subject: Re: [PATCH v4] gpu/trace: add a gpu total memory usage tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     mingo@redhat.com, elder@kernel.org, federico.vaga@cern.ch,
        tony.luck@intel.com, vilhelm.gray@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de,
        yamada.masahiro@socionext.com, paul.walmsley@sifive.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dariusz Marcinkiewicz <darekm@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 7:56 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 03, 2020 at 09:31:04AM -0500, Steven Rostedt wrote:
> > On Tue, 3 Mar 2020 15:15:05 +0100
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > > On Tue, Mar 03, 2020 at 09:07:03AM -0500, Steven Rostedt wrote:
> > > >
> > > > Greg,
> > > >
> > > > You acked this patch before, did you want to ack it again, and I'll take it
> > > > in my tree?
> > >
> > > Sure, but where did my ack go?  What changed from previous versions???
> > >
> > > Anyway, the patch seems sane enough to me:
> > >
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Your previous ack was was here:
> >
> >   https://lore.kernel.org/lkml/20200213004029.GA2500609@kroah.com/
>
> Yeah, I remember that.
>
> > And the patch changed since then (although, only cosmetically), so your ack
> > was removed. The diff between this patch and the patch you acked is this:
> >
> > -- Steve
> >
> > diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
> > index 3b632a2b5100..1897822a9150 100644
> > --- a/include/trace/events/gpu_mem.h
> > +++ b/include/trace/events/gpu_mem.h
> > @@ -28,34 +28,27 @@
> >   *
> >   */
> >  TRACE_EVENT(gpu_mem_total,
> > -     TP_PROTO(
> > -             uint32_t gpu_id,
> > -             uint32_t pid,
> > -             uint64_t size
> > -     ),
> > -     TP_ARGS(
> > -             gpu_id,
> > -             pid,
> > -             size
> > -     ),
> > +
> > +     TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> > +
> > +     TP_ARGS(gpu_id, pid, size),
> > +
> >       TP_STRUCT__entry(
> >               __field(uint32_t, gpu_id)
> >               __field(uint32_t, pid)
> >               __field(uint64_t, size)
> >       ),
> > +
> >       TP_fast_assign(
> >               __entry->gpu_id = gpu_id;
> >               __entry->pid = pid;
> >               __entry->size = size;
> >       ),
> > -     TP_printk(
> > -             "gpu_id=%u "
> > -             "pid=%u "
> > -             "size=%llu",
> > +
> > +     TP_printk("gpu_id=%u pid=%u size=%llu",
> >               __entry->gpu_id,
> >               __entry->pid,
> > -             __entry->size
> > -     )
> > +             __entry->size)
> >  );
> >
> >  #endif /* _TRACE_GPU_MEM_H */
>
> thanks for the diff, my ack still stands.
>
> greg k-h

Hi guys, thanks for all the help throughout this. After struggling a
while, I failed to figure out when the next merge window is. Could you
help point me to the release calendar or something?  Thanks again!

Best,
Yiwei
