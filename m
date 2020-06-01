Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EF1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E677D20659
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgFACzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 22:55:36 -0400
Received: from kernel.crashing.org ([76.164.61.194]:53922 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgFACzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 22:55:35 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 0512tBW4003157
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 31 May 2020 21:55:15 -0500
Message-ID: <eb08c9ab66d1f9a8aa8732da693928d12ad613ec.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 04/18] nitro_enclaves: Init PCI device driver
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Anthony Liguori <aliguori@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
Date:   Mon, 01 Jun 2020 12:55:10 +1000
In-Reply-To: <b4bd54ca-8fe2-8ebd-f4fc-012ed2ac498a@amazon.com>
References: <20200525221334.62966-1-andraprs@amazon.com>
         <20200525221334.62966-5-andraprs@amazon.com>
         <20200526064819.GC2580530@kroah.com>
         <b4bd54ca-8fe2-8ebd-f4fc-012ed2ac498a@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-26 at 21:35 +0300, Paraschiv, Andra-Irina wrote:
> This was needed to have an identifier for the overall NE logic - PCI 
> dev, ioctl and misc dev.
> 
> The ioctl and misc dev logic has pr_* logs, but I can update them to 
> dev_* with misc dev, then remove this prefix.

Or #define pr_fmt, but dev_ is better.

Cheers,
Ben.


