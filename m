Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B5EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E20C206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLs/bSEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgIASY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgIASYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:24:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8AC061244;
        Tue,  1 Sep 2020 11:24:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m23so2410008iol.8;
        Tue, 01 Sep 2020 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6eOAwwv7MGhiV6uSQC+4Pepfi5boLDT2O8Y3f/TMPk=;
        b=eLs/bSEqYDaz+P3iZLzdmLXfBxFyLMzskjfDUf8fpsbByHUl3y85wi/ROgbQ/iwIW4
         dRVFky99AKU/3ujHtRZdfRtT28m4LsGDzPHwkG8G6s6mdQiPdDPEGdMlFB7luQe7kFue
         t+pWkGZWaOv1L7hQlOexAu4hv02+H6RoxC6lwNcXbMqRJmdII3TBHRr9d0hnA0hJMXlB
         pwRpqjo9SO1OpUinUBYzzdODVQyf1vMqAdaTkHs9oHQJly1b21LuhX2VZfvJWIa8z1CT
         oSskLQNDyG/YWg/6hJ/V4g7YVvpxmmMeVysKoCxZajqQDWCXNECfhgzvc53qE54qnwWx
         x+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6eOAwwv7MGhiV6uSQC+4Pepfi5boLDT2O8Y3f/TMPk=;
        b=CHzeIddLv31+f0DN3BJrVJrv9DBonWrHr2drpUBLgl0y26Bl6eO36Lc6dOJlPcDbBe
         q3qcqrAKnQYH5ezH3HQ1MQlU1EsgNaEdvd5UwgcbQS+55MKjjAxpNB+Bwx+LYTgAX+jY
         LTxdxtUyX3WbvZUgqKdF2uCvRE9cdrQRXIJnGZpAl+8aPgjo26KEPqgnjpfpe2rqsksZ
         Ln/YvJ/03wZAgCqbTesHsrAnChNVrWGsDR515jbc1AhVE29UlsIes742OCO+YMBFYFet
         U8HAhSXQ9tjCmGE42a4jK8ulCX+gb3tFr/TenwLaxSOEnGoDQnAJw9B/qks/InYm03cf
         G/dw==
X-Gm-Message-State: AOAM530Za96iCt94P/706zAgIIEYl8eu2tlI4YsFMlFWvqcY0KCLBQ2R
        at0NiOuQQCHU9lhk0fa9WjikJ5yAkq5rXSbJfQw=
X-Google-Smtp-Source: ABdhPJxLGAF9salk9TYGScrQQd96qD+61R30Het3cQa2i//udJ5YGmkLWrQMWDlE9/8Qq968iRn7sRqmKBUeKXbJdKI=
X-Received: by 2002:a02:778e:: with SMTP id g136mr2616404jac.49.1598984694291;
 Tue, 01 Sep 2020 11:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <1598921718-79505-1-git-send-email-linyunsheng@huawei.com>
In-Reply-To: <1598921718-79505-1-git-send-email-linyunsheng@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 1 Sep 2020 11:24:43 -0700
Message-ID: <CAM_iQpVtb3Cks-LacZ865=C8r-_8ek1cy=n3SxELYGxvNgkPtw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sch_generic: aviod concurrent reset and
 enqueue op for lockless qdisc
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 5:59 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> Currently there is concurrent reset and enqueue operation for the
> same lockless qdisc when there is no lock to synchronize the
> q->enqueue() in __dev_xmit_skb() with the qdisc reset operation in
> qdisc_deactivate() called by dev_deactivate_queue(), which may cause
> out-of-bounds access for priv->ring[] in hns3 driver if user has
> requested a smaller queue num when __dev_xmit_skb() still enqueue a
> skb with a larger queue_mapping after the corresponding qdisc is
> reset, and call hns3_nic_net_xmit() with that skb later.

Can you be more specific here? Which call path requests a smaller
tx queue num? If you mean netif_set_real_num_tx_queues(), clearly
we already have a synchronize_net() there.

>
> Avoid the above concurrent op by calling synchronize_rcu_tasks()
> after assigning new qdisc to dev_queue->qdisc and before calling
> qdisc_deactivate() to make sure skb with larger queue_mapping
> enqueued to old qdisc will always be reset when qdisc_deactivate()
> is called.

Like Eric said, it is not nice to call such a blocking function when
we have a large number of TX queues. Possibly we just need to
add a synchronize_net() as in netif_set_real_num_tx_queues(),
if it is missing.

Thanks.
