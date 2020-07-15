Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB724C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA7F20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOUa04qK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGOWfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOWfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:35:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA5C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:35:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x62so3242289qtd.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Awkw/2JAwqx0ybW5si+vH0X/DyLIxSnakUSW3oK3Jgw=;
        b=LOUa04qKaz/Ofcf+7hmtIod7M0nu+L4V6ALEKBSnPvwBrpWstPGKol0ZoZ7CpCc4ho
         8f+vAm4TlU9Q94isUQSM1oijBsrajq+4IyMT7YJJomWLl0icFaFnaE1UNK47LN/Uoe2v
         XsEom275tqbMGnLrmD8dw5eHCIgEwvlDWPvwpkcORZ1I6y8KVPFbmB46kuquSC92PW++
         f71PG3hbwn9P4Y50EpDPpobD/JvOqU/Ml0egLRtlu96Lxo0l3zPvNGxGRW23xOoMnkiO
         U5qU/fTViZtlUS6YBZ0ADkCNxrX/17d9N5ASPEj0q7T43QbfM2jrtT0HGJXV3m5pERr5
         SbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Awkw/2JAwqx0ybW5si+vH0X/DyLIxSnakUSW3oK3Jgw=;
        b=ah7faMu+dXgdIqksPcuH+mEZ2S5fx+UFuoJilR1t4UhF3CLZInreg9s1LB6dzJfqxs
         F9r7FtpCdPEz/370TS17Lp3CURib+exSDvgjJz0m5MQ+sFOB/nOMvz6ieSQ6vmPYCgkM
         +2p7VmZySx3/urIqK3l2VpdV7ShjOXYm2zwPSInaI0bpZH5dwFxViH+yI4VIubm9WbFN
         W4GTmcocvZe1EvPN5crzbQrMhTmnhdPgv8THkGOfsoFbYy73Z3sruzWJnoxg7y/i6Vq3
         bNjNXYGjm6LhBpWVLYNIfVgxOVpakNaswKnauQYBVlcVcctAtkW4LXXmIVTmRJwXV3xZ
         14ZQ==
X-Gm-Message-State: AOAM530aVWmsxnB7+WFSOu5tkk41BtzU0dH6CSuREl5tKdvTZgHc4Cui
        84uaObsX9pn9m2mN0sMxT95xvPKg
X-Google-Smtp-Source: ABdhPJzbim4i+IGyQLiqMd7x2i7t7dZJH2wDmCNA8LvsGb34jbZz82TM7HAnMlubycTJJp7g1SPFEA==
X-Received: by 2002:ac8:1667:: with SMTP id x36mr2254965qtk.344.1594852539335;
        Wed, 15 Jul 2020 15:35:39 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id p36sm5054865qte.90.2020.07.15.15.35.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 15:35:38 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id f5so1913405ybq.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:35:38 -0700 (PDT)
X-Received: by 2002:a25:df81:: with SMTP id w123mr2058601ybg.428.1594852537696;
 Wed, 15 Jul 2020 15:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200707152204.10314-1-john.ogness@linutronix.de> <20200715132141.2c72ae75@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200715132141.2c72ae75@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 15 Jul 2020 18:35:00 -0400
X-Gmail-Original-Message-ID: <CA+FuTSe1WXLGKd2zNLmQiKTZeNN64R-vGJTNMuVD_4VA8AN5Fg@mail.gmail.com>
Message-ID: <CA+FuTSe1WXLGKd2zNLmQiKTZeNN64R-vGJTNMuVD_4VA8AN5Fg@mail.gmail.com>
Subject: Re: [PATCH] af_packet: TPACKET_V3: replace busy-wait loop
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 4:21 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue,  7 Jul 2020 17:28:04 +0206 John Ogness wrote:
> > A busy-wait loop is used to implement waiting for bits to be copied
> > from the skb to the kernel buffer before retiring a block. This is
> > a problem on PREEMPT_RT because the copying task could be preempted
> > by the busy-waiting task and thus live lock in the busy-wait loop.
> >
> > Replace the busy-wait logic with an rwlock_t. This provides lockdep
> > coverage and makes the code RT ready.
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
>
> Is taking a lock and immediately releasing it better than a completion?
> Seems like the lock is guaranteed to dirty a cache line, which would
> otherwise be avoided here.
>
> Willem, would you be able to take a look as well? Is this path
> performance sensitive in real life?

No objections from me.

I guess this resolves the issue on preempt_rt, because the spinlocks act as
mutexes. It will still spin on write_lock otherwise, no huge difference from
existing logic.





>
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 29bd405adbbd..dd1eec2dd6ef 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -593,6 +593,7 @@ static void init_prb_bdqc(struct packet_sock *po,
> >                                               req_u->req3.tp_block_size);
> >       p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> >       p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
> > +     rwlock_init(&p1->blk_fill_in_prog_lock);
> >
> >       p1->max_frame_len = p1->kblk_size - BLK_PLUS_PRIV(p1->blk_sizeof_priv);
> >       prb_init_ft_ops(p1, req_u);
> > @@ -659,10 +660,9 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> >        *
> >        */
> >       if (BLOCK_NUM_PKTS(pbd)) {
> > -             while (atomic_read(&pkc->blk_fill_in_prog)) {
> > -                     /* Waiting for skb_copy_bits to finish... */
> > -                     cpu_relax();
> > -             }
> > +             /* Waiting for skb_copy_bits to finish... */
> > +             write_lock(&pkc->blk_fill_in_prog_lock);
> > +             write_unlock(&pkc->blk_fill_in_prog_lock);
> >       }
> >
> >       if (pkc->last_kactive_blk_num == pkc->kactive_blk_num) {
> > @@ -921,10 +921,9 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
> >                * the timer-handler already handled this case.
> >                */
> >               if (!(status & TP_STATUS_BLK_TMO)) {
> > -                     while (atomic_read(&pkc->blk_fill_in_prog)) {
> > -                             /* Waiting for skb_copy_bits to finish... */
> > -                             cpu_relax();
> > -                     }
> > +                     /* Waiting for skb_copy_bits to finish... */
> > +                     write_lock(&pkc->blk_fill_in_prog_lock);
> > +                     write_unlock(&pkc->blk_fill_in_prog_lock);
> >               }
> >               prb_close_block(pkc, pbd, po, status);
> >               return;
> > @@ -944,7 +943,8 @@ static int prb_queue_frozen(struct tpacket_kbdq_core *pkc)
> >  static void prb_clear_blk_fill_status(struct packet_ring_buffer *rb)
> >  {
> >       struct tpacket_kbdq_core *pkc  = GET_PBDQC_FROM_RB(rb);
> > -     atomic_dec(&pkc->blk_fill_in_prog);
> > +
> > +     read_unlock(&pkc->blk_fill_in_prog_lock);
> >  }
> >
> >  static void prb_fill_rxhash(struct tpacket_kbdq_core *pkc,
> > @@ -998,7 +998,7 @@ static void prb_fill_curr_block(char *curr,
> >       pkc->nxt_offset += TOTAL_PKT_LEN_INCL_ALIGN(len);
> >       BLOCK_LEN(pbd) += TOTAL_PKT_LEN_INCL_ALIGN(len);
> >       BLOCK_NUM_PKTS(pbd) += 1;
> > -     atomic_inc(&pkc->blk_fill_in_prog);
> > +     read_lock(&pkc->blk_fill_in_prog_lock);
> >       prb_run_all_ft_ops(pkc, ppd);
> >  }
> >
> > diff --git a/net/packet/internal.h b/net/packet/internal.h
> > index 907f4cd2a718..fd41ecb7f605 100644
> > --- a/net/packet/internal.h
> > +++ b/net/packet/internal.h
> > @@ -39,7 +39,7 @@ struct tpacket_kbdq_core {
> >       char            *nxt_offset;
> >       struct sk_buff  *skb;
> >
> > -     atomic_t        blk_fill_in_prog;
> > +     rwlock_t        blk_fill_in_prog_lock;
> >
> >       /* Default is set to 8ms */
> >  #define DEFAULT_PRB_RETIRE_TOV       (8)
>
