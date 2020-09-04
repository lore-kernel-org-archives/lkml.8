Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBCDC2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB832074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgIDLmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:42:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729582AbgIDLms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:42:48 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-p498XuqzMIS4zRGB4u3OZg-1; Fri, 04 Sep 2020 07:42:43 -0400
X-MC-Unique: p498XuqzMIS4zRGB4u3OZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BF1E890EA9;
        Fri,  4 Sep 2020 11:42:30 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.40.208.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5221C50B44;
        Fri,  4 Sep 2020 11:42:26 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     vdronov@redhat.com
Cc:     ap420073@gmail.com, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH] debugfs: Fix module state check condition
Date:   Fri,  4 Sep 2020 13:42:07 +0200
Message-Id: <20200904114207.375220-1-vdronov@redhat.com>
In-Reply-To: <20200811150129.53343-1-vdronov@redhat.com>
References: <20200811150129.53343-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Dear maintainers, could you please look at the above patch, that
previously was sent during a merge window?

A customer which has reported this issue replied with a test result:

> I ran the same test.
> Started ib_write_bw traffic and started watch command to read RoCE
> stats : watch -d -n 1 "cat /sys/kernel/debug/bnxt_re/bnxt_re0/info".
> While the command is running, unloaded roce driver and I did not
> observe the call trace that was seen earlier.

Regards,
Vladis

