Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC79AC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C979520663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgCOOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:37:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49526 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCOOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:37:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDUO1-00ByfE-Tw; Sun, 15 Mar 2020 14:37:05 +0000
Date:   Sun, 15 Mar 2020 14:37:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH v4 26/69] sanitize handling of nd->last_type, kill
 LAST_BIND
Message-ID: <20200315143705.GW23230@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200315102905.12468-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315102905.12468-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 06:29:05PM +0800, Hillf Danton wrote:

> > And make link_path_walk() _always_ assign ->last_type - in the only
> > case when the value at the entry might survive to the return that value
> > is always LAST_ROOT, inherited from path_init().  Move that assignment
> > from path_init() into the beginning of link_path_walk(), to consolidate
> > the things.
> > 
> If you agree that the move is not a huge change, drop it for the sake of
> init in order to close the time window of a random last_type.

What time window of a random last_type and what does "drop for the sake of
init" mean?  Confused...
