Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C165BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952EB2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lpzj/LxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFPIJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:09:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgFPIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592294939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lNFuwmVizYLxWwU92PSfYVlqBtEwsiUDHr4aylkwW0=;
        b=Lpzj/LxPGv0xl3GYVuxS+q8BMexUxywiQIUVrXL+qlJsxgyy2qc57T0Vzqf2fybty86uv2
        DvX25oGYGBjwWDTdRvwMmTBfzlhnPHcgcBG5Nlj2cuxp/u/UWti2PJd7Ql2WVlZhSO/Irz
        TxHOku5JG5Xv6mvG2RTnGp2MisWI6JQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-2FzjiqL7O4qN4k74nylQvQ-1; Tue, 16 Jun 2020 04:08:55 -0400
X-MC-Unique: 2FzjiqL7O4qN4k74nylQvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6547C803308;
        Tue, 16 Jun 2020 08:08:53 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1980219C79;
        Tue, 16 Jun 2020 08:08:53 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 78459833B1;
        Tue, 16 Jun 2020 08:08:52 +0000 (UTC)
Date:   Tue, 16 Jun 2020 04:08:52 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, ltp@lists.linux.it,
        Serge Hallyn <serge@hallyn.com>
Message-ID: <348139455.16141709.1592294932212.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
References: <20200615085836.GR12456@shao2-debian> <20200615091850.GA3373@yuki.lan> <1101600340.15989438.1592229781375.JavaMail.zimbra@redhat.com> <20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
Subject: Re: [LTP] 303cc571d1: ltp.setns01.fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.25, 10.4.195.3]
Thread-Topic: 303cc571d1: ltp.setns01.fail
Thread-Index: nYZtIeM5D1sw8KRcMGIO9za2Kof/yw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> I'll send a pr for this to Linus this week (or next since I'm on
> vacation this week) and get this fixed. Thanks for spotting this. What's
> the Reported-by: line format that LTP uses?

I'm not sure we ever used one, it's usually various CI systems that
reference LTP. This thread has been started by kernel test robot:
  Reported-by: kernel test robot <rong.a.chen@intel.com>

