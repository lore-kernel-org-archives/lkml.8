Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C80C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE752067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBRUHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:07:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57704 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgBRUHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:07:44 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j499i-00EtDJ-L6; Tue, 18 Feb 2020 20:07:42 +0000
Date:   Tue, 18 Feb 2020 20:07:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: deny and force are not huge mount options
Message-ID: <20200218200742.GK23230@ZenIV.linux.org.uk>
References: <alpine.LSU.2.11.2002171959001.1412@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2002171959001.1412@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 08:04:19PM -0800, Hugh Dickins wrote:
> 5.6-rc1 commit 2710c957a8ef ("fs_parse: get rid of ->enums") regressed
> the huge tmpfs mount options to an earlier state: "deny" and "force"
> are not valid there, and can crash the kernel.  Delete those lines.

Applied to #fixes, will send to Linus tonight.
