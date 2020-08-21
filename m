Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15D5207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHUJ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:29:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:53232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbgHUJ3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:29:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8EC9B189;
        Fri, 21 Aug 2020 09:30:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6D5DDA730; Fri, 21 Aug 2020 11:28:44 +0200 (CEST)
Date:   Fri, 21 Aug 2020 11:28:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     jikos@kernel.org, dsterba@suse.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: ipwireless: fix error handling
Message-ID: <20200821092844.GB2026@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Tong Zhang <ztong0001@gmail.com>,
        jikos@kernel.org, dsterba@suse.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org
References: <b360242d-f488-da51-9d47-36b2abdf90cd@kernel.org>
 <20200818160401.4736-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818160401.4736-1-ztong0001@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:03:58PM -0400, Tong Zhang wrote:
> ipwireless_send_packet() can only return 0 on success and -ENOMEM on
> error, the caller should check non zero for error condition

Thanks.

Acked-by: David Sterba <dsterba@suse.com>

---
> v2: - According to Jiri's comment, I made the checking consistent with
> the rest of the kernel. I also rebased the code using f684668a24ec.
> Thank you Jiri!
---

This paragraph should not be in the changelog. The patches to ipwireless
go via Greg's tree, please send an updated v3 so he can just apply that
without further edits.  Thanks.
