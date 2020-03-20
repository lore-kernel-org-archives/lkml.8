Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417E7C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C4C2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8W6322Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgCTXxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:53:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40160 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTXxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:53:42 -0400
Received: by mail-io1-f68.google.com with SMTP id h18so7906477ioh.7;
        Fri, 20 Mar 2020 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKtX3XsPK0x/T0OMk3ex7iQL++t5aTe227uSyhjTMuw=;
        b=Z8W6322Yy3C2QWBTL6KGNVo+NCWp6LkDgxzjvBD12bGchzZmqjiKxu8S1SLa4/8ZyZ
         LRvLjCMJg3Uf5rqDOMK5LX8TJAcYcaG/m3Pq00l9o/B8FK7KpGA3g4gUw+InFJ0j4O23
         mNaO7aqWvEN2vJbKtqJma1BJwqJof5xRMZUCL4w4RDIbL51r3pofrvofSm90yvY2aoK0
         kCBF3C1G5K+0Cm1+5bw3ZSw+oaIvSLIxxdwVeo8+knpQqG7wYx5qapodNS8Ofp2hIIym
         a8c2B+f1NlO6OCpTuvcXV2ak80cZPWt17+vYFWcvo/mAAq6ayuAEq1S+rrqSVT+zMu8B
         YdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKtX3XsPK0x/T0OMk3ex7iQL++t5aTe227uSyhjTMuw=;
        b=K0idLmXb7Ph0YJWV1yTOnm56+Qzk/Lxf9eZTNs05w/s4YVCvv9FggvNski+MN6zWGs
         WHkodstuIMpwx1HgnLZmFXrFUuEniuu0YcuR1rIGvPi3vD6JZY2lTenBtHdJrl48q/vO
         JRNFVFMUE1fwoS5Bh1NMvbAE7cag5Ao5cfYCdJ5RFC4dG4b4KQNL9cHm8ySvyd7j6IEW
         dvZ0XD8yE1NLh4sxvqToX4pTvGr6LAs/DPAvNjOs6ehFtjP+VGrtaO11+TQO/Q7prnkl
         rZ0kQvnCUPlQTX2YGLaaqZ9z0UMMnKN1n98vLosV7NyGVGihUU2vfRyUsO/VKKeckVlR
         ZbVQ==
X-Gm-Message-State: ANhLgQ27NGwO+lBXU+gtinIZh70+4gqOSD2hYcDJfVR9hGwNiwtO9QqP
        h3M8qNVTsFZ9uvapNPSqpGjXDnyrvVZ1qmCUhfo=
X-Google-Smtp-Source: ADFU+vvIqEsKaEyeE8ULMwxKomVDncLG2PjT8bMo6bP/MjNX+49wkqt+YxNYXS+pVAsPhXo8VX9LMWJIT4tSARdj598=
X-Received: by 2002:a6b:f404:: with SMTP id i4mr9845414iog.175.1584748421648;
 Fri, 20 Mar 2020 16:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200320110959.2114-1-hqjagain@gmail.com> <20200320185204.GB3828@localhost.localdomain>
In-Reply-To: <20200320185204.GB3828@localhost.localdomain>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sat, 21 Mar 2020 07:53:29 +0800
Message-ID: <CAJRQjoc-U_K-2THbmBOj2TOWDTfP9yr5Vec-WjhTjS8sj19fHA@mail.gmail.com>
Subject: Re: [PATCH v3] sctp: fix refcount bug in sctp_wfree
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, vyasevich@gmail.com,
        nhorman@tuxdriver.com, Jakub Kicinski <kuba@kernel.org>,
        linux-sctp@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, anenbupt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 2:52 AM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Fri, Mar 20, 2020 at 07:09:59PM +0800, Qiujun Huang wrote:
> > Do accounting for skb's real sk.
> > In some case skb->sk != asoc->base.sk:
> >
> > for the trouble SKB, it was in outq->transmitted queue
> >
> > sctp_outq_sack
> >       sctp_check_transmitted
> >               SKB was moved to outq->sack
>
> There is no outq->sack. You mean outq->sacked, I assume.
>
> >       then throw away the sack queue
>
> Where? How?
> If you mean:
>         /* Throw away stuff rotting on the sack queue.  */
>         list_for_each_safe(lchunk, temp, &q->sacked) {
>                 tchunk = list_entry(lchunk, struct sctp_chunk,
>                                     transmitted_list);
>                 tsn = ntohl(tchunk->subh.data_hdr->tsn);
>                 if (TSN_lte(tsn, ctsn)) {
>                         list_del_init(&tchunk->transmitted_list);
>                         if (asoc->peer.prsctp_capable &&
>                             SCTP_PR_PRIO_ENABLED(chunk->sinfo.sinfo_flags))
>                                 asoc->sent_cnt_removable--;
>                         sctp_chunk_free(tchunk);
>
> Then sctp_chunk_free is supposed to free the datamsg as well for
> chunks that were cumulative-sacked.
> For those not cumulative-sacked, sctp_for_each_tx_datachunk() will
> handle q->sacked queue as well:
>         list_for_each_entry(chunk, &q->sacked, transmitted_list)
>                 cb(chunk);
>
> So I don't see how skbs can be overlooked here.
>
> >               SKB was deleted from outq->sack
> > (but the datamsg held SKB at sctp_datamsg_to_asoc
>
> You mean sctp_datamsg_from_user ? If so, isn't it the other way
> around? sctp_datamsg_assign() will hold the datamsg, not the skb.
>
> > So, sctp_wfree was not called to destroy SKB)
> >
> > then migrate happened
> >
> >       sctp_for_each_tx_datachunk(
> >       sctp_clear_owner_w);
> >       sctp_assoc_migrate();
> >       sctp_for_each_tx_datachunk(
> >       sctp_set_owner_w);
> > SKB was not in the outq, and was not changed to newsk
>
> The real fix is to fix the migration to the new socket, though the
> situation on which it is happening is still not clear.
>
> The 2nd sendto() call on the reproducer is sending 212992 bytes on a
> single call. That's usually the whole sndbuf size, and will cause
> fragmentation to happen. That means the datamsg will contain several
> skbs. But still, the sacked chunks should be freed if needed while the
> remaining ones will be left on the queues that they are.

in sctp_sendmsg_to_asoc
datamsg holds his chunk result in that the sacked chunks can't be freed

list_for_each_entry(chunk, &datamsg->chunks, frag_list) {
sctp_chunk_hold(chunk);
sctp_set_owner_w(chunk);
chunk->transport = transport;
}

any ideas to handle it?

>
> Thanks,
> Marcelo
