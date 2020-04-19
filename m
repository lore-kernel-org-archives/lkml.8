Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972CEC54FC9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C6822202
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgDSQm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:42:56 -0400
Received: from gentwo.org ([3.19.106.255]:34976 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgDSQm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:42:56 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 3D7793F57C; Sun, 19 Apr 2020 16:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 3C2E83E96E;
        Sun, 19 Apr 2020 16:42:55 +0000 (UTC)
Date:   Sun, 19 Apr 2020 16:42:55 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?GB2312?B?1dS+/L/8?= <bernard@vivo.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re:Re: [PATCH] kmalloc_index optimization(add kmalloc max size
 check)
In-Reply-To: <ALcAggApCIauiL91uBghEaoS.3.1587173574288.Hmail.bernard@vivo.com>
Message-ID: <alpine.DEB.2.21.2004191642290.14792@www.lameter.com>
References: <ALcAggApCIauiL91uBghEaoS.3.1587173574288.Hmail.bernard@vivo.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-1815511817-1587314575=:14792"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-1815511817-1587314575=:14792
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 18 Apr 2020, 赵军奎 wrote:

> Sorry for the misunderstanding.

What misunderstanding?

> But the current code is not, kmalloc_index will only be BUG() when it exceeds 64M.

Yes that is what you may want to fix as I said.

--531401748-1815511817-1587314575=:14792--
