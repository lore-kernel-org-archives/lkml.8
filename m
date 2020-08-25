Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F07FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E2620738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhWogwVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHYSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgHYSqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598381183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=EX4xXGP362ALPv/lOdd4O23mdmXEiwTrEdzpI5x9aws=;
        b=BhWogwVtQxZlZv3MqNCI+eyh21Y48K7IBOp+qqIt65ZTeSdMYwzWzriNXGysFGy7Iz+Tt9
        Lo9R7P3DtMQsiZzk2V9oIbVP3IGisdnukfqeQsAvhNHh9i5JpBuLgs+hUo71uATLtnHb6s
        fIbwfhVIzY6Z2yD3z9AlDo3AAZk+3ng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-a0wkXCM_NpOun_-f3qblyA-1; Tue, 25 Aug 2020 14:46:21 -0400
X-MC-Unique: a0wkXCM_NpOun_-f3qblyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1DC41008550;
        Tue, 25 Aug 2020 18:46:20 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-10.gru2.redhat.com [10.97.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C29760C0F;
        Tue, 25 Aug 2020 18:46:20 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 319E6409D738; Tue, 25 Aug 2020 15:44:50 -0300 (-03)
Message-ID: <20200825184147.948670309@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 25 Aug 2020 15:41:47 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [patch 0/2] posix-timers: avoid nohz_full= IPIs via task cpu masks
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset avoids IPIs to nohz_full= CPUs when the intersection 
between the set of nohz_full CPUs and task allowed cpus is null.

See individual patches for details.


