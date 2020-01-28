Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F9B24685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221967;
	bh=4VyhmAZkT+dM03W/pxTczHQWhzVYTW6AxR3LgFMf4AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2exeT4Pm6i5Eu7/yDKkNxJgJzaw1l5rRmgnovAkGaH6GlvK5W3/DslpONcpvHfAx
	 LlfKXWtZthvIA7GmIIyxFGnEfZY8NhtIXHICiYrERw8rKR63I0fJajPJW+snnYV8j7
	 Opqox2af5VkZVvYdJfA5UdMpx9dtdNg/olzY0uok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbgA1O0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:26:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730514AbgA1O0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:26:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED01720716;
        Tue, 28 Jan 2020 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221560;
        bh=4VyhmAZkT+dM03W/pxTczHQWhzVYTW6AxR3LgFMf4AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHsVP3vFItOlJPyiDOwwu0f1gF7+oUKeEbSI+Kj9SXjA1wq4V3cVQgcKUtNpnfcfy
         ZrcwPS0Q1TfVh9PqckSmu3xV3DtbC+K3v6avJ/CfOwnuRXur9fLCAcTUAuORThflcR
         Zt588l6EiMRAb5CHYcDjAQuWtsvwgsNEE7WiHwF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.9 266/271] bcache: silence static checker warning
Date:   Tue, 28 Jan 2020 15:06:55 +0100
Message-Id: <20200128135912.394932405@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit da22f0eea555baf9b0a84b52afe56db2052cfe8d upstream.

In olden times, closure_return() used to have a hidden return built in.
We removed the hidden return but forgot to add a new return here.  If
"c" were NULL we would oops on the next line, but fortunately "c" is
never NULL.  Let's just remove the if statement.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/super.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1398,9 +1398,6 @@ static void cache_set_flush(struct closu
 	struct btree *b;
 	unsigned i;
 
-	if (!c)
-		closure_return(cl);
-
 	bch_cache_accounting_destroy(&c->accounting);
 
 	kobject_put(&c->internal);


