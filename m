Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD60C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E12522B42
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595450365;
	bh=cSAkTV0rvULhkTDYAX0TFBSOxsananBIFa2o9Sm6ws0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DRGapyrP8ok8pQ2jHtqKnunN5EberWY18QyY8F9Tvr2mdM4/omepzAt1YZ3TBeHEa
	 D3BJF2gB96ZYroQBPTYCqdlZMD9V5VY1EQqAC+PTGSGahgE3Xt1so/XCOyed2TD0aw
	 nLa7l/HFbcEg9jQ7Wu3CMPGaZTXUbt0NSP+/U6/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGVUjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGVUjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:39:23 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E341D20709;
        Wed, 22 Jul 2020 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595450363;
        bh=cSAkTV0rvULhkTDYAX0TFBSOxsananBIFa2o9Sm6ws0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDsnccgjqcnfdMAevRrkt46qhSMjpfmNtb86JnoDvK8p/Xu/3EfXpu3Z2ntEJO++3
         zQRzJz4LnrfRldR33CQ9o2xECi/+tIOTb+rQVw1CgDU04GPz+D925ZGcFqK+9BZ8z2
         6THDxiaZwU94XRx26nK+XXO/CQEHQwz7ElsZs6vQ=
Date:   Wed, 22 Jul 2020 16:39:21 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@collabora.com, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, krisman@collabora.com,
        Nikolaus Rath <Nikolaus@rath.org>,
        Hugh Dickins <hughd@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 5.7 1/1] fuse: fix weird page warning
Message-ID: <20200722203921.GD406581@sasha-vm>
References: <20200721185459.103445-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721185459.103445-1-andrealmeid@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 03:54:59PM -0300, André Almeida wrote:
>From: Miklos Szeredi <mszeredi@redhat.com>
>
>commit a5005c3cda6eeb6b95645e6cc32f58dafeffc976 upstream.
>
>When PageWaiters was added, updating this check was missed.
>
>Reported-by: Nikolaus Rath <Nikolaus@rath.org>
>Reported-by: Hugh Dickins <hughd@google.com>
>Fixes: 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")
>Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>Signed-off-by: André Almeida <andrealmeid@collabora.com>

Queued for 5.7-4.19, thanks!

-- 
Thanks,
Sasha
