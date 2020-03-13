Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C39C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C7B2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isEHg/DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgCMUua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:50:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40729 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCMUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:50:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id f3so6797328wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLkqiJ6k+u/kdHhnSAw6oeqKV753A2DLJwmyLzR9Ev8=;
        b=isEHg/DYtMvvf9cJ6uBf/T6xaEz0sze5nU3jhjbEf7S/EPwBflp8U/kIkNMCY/qyz1
         qMX9lQb5mtQ5Xf2ivw+Qmb7Tb30Dwg9G0RkLdszctk6Dpwy2wRzFjBXbifvmq/T1SmNv
         qo01RSPIiZY5eZuzHEFsOrU5dySp5/mq6mOTERonUBh2VVLl71jog/KgErvfHb2HU2SH
         9LCVUJZBdjQUz41raD0X6fQfSdEcUhZjb8p1rtNnzNg+t9kMTF5HfHs0HjqlNIHq7DPh
         O8rpMkjPl6BfyzY0cbPUGUdBPtW6m10Adr9A00HBFQB3rea7oC8g8LSq6q8I5peYlpCp
         0/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLkqiJ6k+u/kdHhnSAw6oeqKV753A2DLJwmyLzR9Ev8=;
        b=XQeNs5BMGo8YE3eYkB74ko7/2+Ceue0yjqVuTb/6LvVBm5pttIhhceGYZ8mTN4AsR1
         BCj1uPJXH0jMu14iz9NWsTAI95dtnu66RtQC0AquCGACNYiu1IXU7nVRk4U0Lv3f96o/
         pb5XLqndAYDw1PoWiaXU8sQNF9UzapSNbU4kux8rVPT9yaIp/golA9COWIXNsnWlJ3AZ
         1/rw8H8GpmkLsPy+Pok21U0Iv/hwkO977+bee4TP3e89ptX5s2PB9c+rK1LDTwuV3vOn
         kjOfV6X2LSWaHI0/Smefr0cnVrIuK6lAb3pC0ClXlg5TxtKbjD3mF+2inKcFfxbav13o
         AVWg==
X-Gm-Message-State: ANhLgQ0bTZYZAnxmdHfKe4WTCeULgs2d31RbeUc7UxEGgRCHBz4hmT4u
        NfSVH3HUkn+bWmGNB1rz1UHYncqukp1liVqR6FMriw==
X-Google-Smtp-Source: ADFU+vvW9cAi0S/7XO82Pk2Gb60oXJm1bKDvJGuJ1Yt6AWKHfPFxYBS8s85mdVuI8KNq54wfS/KWXJQUoa48/OKK9FE=
X-Received: by 2002:adf:afdb:: with SMTP id y27mr19990685wrd.208.1584132627671;
 Fri, 13 Mar 2020 13:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200311235653.141701-1-rammuthiah@google.com> <20200312082427.GA32229@infradead.org>
In-Reply-To: <20200312082427.GA32229@infradead.org>
From:   Ram Muthiah <rammuthiah@google.com>
Date:   Fri, 13 Mar 2020 13:50:01 -0700
Message-ID: <CA+CXyWsw1VGMvETx8Qb=x7PjTsRR5XATbnHkfht1jij54SO75A@mail.gmail.com>
Subject: Re: [PATCH] Inline contents of BLK_MQ_VIRTIO config
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 1:24 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Mar 11, 2020 at 04:56:53PM -0700, Ram Muthiah wrote:
> > The config contains one symbol and is a dep of only two configs.
> > Inlined this symbol so that it's built in by the two configs
> > which need it and deleted the config.
>
> So now we build the code twice instead of once.  Nevermind that you
> have dropped the copyright noticed.  What is the point?
>

The android kernel team is working towards generating a generic
kernel that can be used across many devices. One of the devices in
question is cuttlefish, a android virtual device that relies on
virtio blk.

The config here, blk_mq_virtio, is needed for virtio-blk but it is
binary. blk-mq-virtio cannot be built into this generic kernel in the
interest of keeping all virtio related configs as modules. (This
compromise is needed to enable all physical devices to run this
generic kernel.)

To fix this problem, there are two paths forward that I see. The
patch proposed fixes the problem by inling the one symbol
blk_mq_virtio has since this symbol is used in just two tristate
virtio configs. Additionally, the symbol is fairly small so this
doesn't seem like a bad solution.

Alternatively, I could modularize blk-mq-virtio. It does look like
this config was meant to be tristate based on the include of the
module header and the export of blk_mq_virtio_map_queues.

If the latter approach is preferred, I'd be happy to resubmit the
patch.
