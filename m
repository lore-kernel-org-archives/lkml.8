Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FD5C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:02:06 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F301320735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F301320735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgDMGCE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgDMGCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:02:04 -0400
Received: from ns207790.ip-94-23-215.eu (poy.remlab.net [94.23.215.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28410C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:02:02 -0700 (PDT)
Received: from basile.remlab.net (87-92-31-51.bb.dnainternet.fi [87.92.31.51])
        (Authenticated sender: remi)
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id A829D5FC58;
        Mon, 13 Apr 2020 08:01:59 +0200 (CEST)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     netdev@vger.kernel.org, courmisch@gmail.com, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at net/phonet/socket.c:LINE!
Date:   Mon, 13 Apr 2020 09:01:58 +0300
Message-ID: <2585533.60Y2ixrnJE@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20200413054914.euz7g2fcxsr74lfm@shells.gnugeneration.com>
References: <00000000000062b41d05a2ea82b0@google.com> <1806223.auBmcZeozp@basile.remlab.net> <20200413054914.euz7g2fcxsr74lfm@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le maanantaina 13. huhtikuuta 2020, 8.49.14 EEST Vito Caputo a écrit :
> > If we are to distinguish the two error scenarii, then it's the rebind 
> > case
> > that needs a different error, but EINVAL is consistent with INET.
> 
> Isn't the existing code is bugged if treating -EINVAL as valid and a rebind?
> 
> The invalid size will return a NULL sobject but -EINVAL, triggering the
> BUG_ON.

How do you pass an invalid size? It's a constant `sizeof(struct sockaddr_pn)` 
in that code path.

-- 
Rémi Denis-Courmont
Tapiolan uusi kaupunki, Uudenmaan tasavalta



