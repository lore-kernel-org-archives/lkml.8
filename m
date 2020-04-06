Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C92C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B269E20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgDFMIO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:08:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34267 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgDFMIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:08:14 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B2988CECC4;
        Mon,  6 Apr 2020 14:17:46 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1] Bluetooth: debugfs option to unset MITM flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJQfnxHUWCDVs5O-sJG8cqQKRrs9UvEjm3Yjv65SoyrzNNGV=Q@mail.gmail.com>
Date:   Mon, 6 Apr 2020 14:08:12 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <39BBAF39-1552-48A2-AC0C-F6148987E804@holtmann.org>
References: <20200406165542.v1.1.Ibfc500cbf0bf2dc8429b17f064e960e95bb228e9@changeid>
 <9673F164-A14E-4DD6-88FB-277694C50328@holtmann.org>
 <CAJQfnxHUWCDVs5O-sJG8cqQKRrs9UvEjm3Yjv65SoyrzNNGV=Q@mail.gmail.com>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Archie,

> The way I implemented it is, if HCI_ENFORCE_MITM_SMP is set (which it
> is by default), then it will assume the default behavior.
> However, if it is toggled to false, then it will not set the MITM flag
> although the io capability supports that.
> 
> I am reluctant to use names with "no" on it, especially since it is a
> boolean. But if it is OK then I shall update to HCI_FORCE_NO_MITM,
> this way it will become more separable with the default behavior.
> 
> Sure, I will move that to hci_debugfs.c.

I dislike setting a flag for default behavior. So we need the invert here. I want the “force” in front of it that it clearly indicates that it is not default behavior. Similar to the force_static_addr flag.

Regards

Marcel

