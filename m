Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAFFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693FB2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIBtzhid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAWNiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:38:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45951 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726729AbgAWNiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579786695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6uD+1e68gi91qvBrZ/lqf2TnuTpmHDoEyL/oCZyo6k=;
        b=MIBtzhidHuL3gfyTami1B0Gbw2dt3VeAgEK2l2zXxCLt5BRHa+Z5Ra85NforfACev7dXmx
        RSTaF6XDQ9gFnsTcdgjDrrELzFjjz7EZYVuU9q6M/Rm+YPYpIFQQK/CLWXlum7VPGxjPoD
        vELHZoHbIcyNhI+7GnS7Lz0mSCdOMkE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-eKdXM8euOsefgA3i7apSsQ-1; Thu, 23 Jan 2020 08:38:14 -0500
X-MC-Unique: eKdXM8euOsefgA3i7apSsQ-1
Received: by mail-lj1-f200.google.com with SMTP id w6so1082765ljo.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h6uD+1e68gi91qvBrZ/lqf2TnuTpmHDoEyL/oCZyo6k=;
        b=XI9hgSbWku7Uj13/NjlgVZExgS4uU7aDv2Ym6GiCRrQWwwt+4Y7cLeLbUzQfTL4we+
         zztoYyR9XY0JMrPX4xE3XPGNZqptgyXuXxezlqUrdpaOPmQiM7OR4qu0fPTC/H5MNSkb
         SVczD1BCzejIP8czb7gCu9V1MKFmHkAFseTnr0Kmg7AzxVc2P6fKHy1mOoTRlFJxN1YI
         VippLr4ArP1DgZd/OhFEWtm2wTKkzlc48CQkP5o/cN4ovzGmJMYlcO3CTbLJDRSTwbCN
         vt/HYpbsQhhxN9keGcJaFb1VlUlXMIRcWk1ydoUYuHDgVpc9qTT6Q+mnODA087VRgrZg
         +VnA==
X-Gm-Message-State: APjAAAVGiZ+VtAExL9x+3oDPmRZ+ErZaxAGc262DfvK9a2dqq2kgssv/
        iZn4woy35dNXQEFbOhxvjiJLtt1pIVe10tXqDoHF4/5A8F917NAGDmYCqgVt+i5tulks16UJ+cX
        /V+6K6jeNAq91W7Z2ZN7661d5
X-Received: by 2002:ac2:50da:: with SMTP id h26mr4787293lfm.80.1579786692705;
        Thu, 23 Jan 2020 05:38:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4BWaWs+3H0Frdse6iV+jJqbBxUwLv0Dvg8acnZgByftBSE4MEGvlY+Jnho0dUBWe823FHAw==
X-Received: by 2002:ac2:50da:: with SMTP id h26mr4787274lfm.80.1579786692511;
        Thu, 23 Jan 2020 05:38:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id s4sm1309808ljd.94.2020.01.23.05.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 05:38:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F36231800FF; Thu, 23 Jan 2020 14:38:10 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Amol Grover <frextrite@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] bpf: devmap: Pass lockdep expression to RCU lists
In-Reply-To: <20200123120437.26506-1-frextrite@gmail.com>
References: <20200123120437.26506-1-frextrite@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 23 Jan 2020 14:38:10 +0100
Message-ID: <87d0ba9ttp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amol Grover <frextrite@gmail.com> writes:

> head is traversed using hlist_for_each_entry_rcu outside an
> RCU read-side critical section but under the protection
> of dtab->index_lock.
>
> Hence, add corresponding lockdep expression to silence false-positive
> lockdep warnings, and harden RCU lists.
>
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Could you please add an appropriate Fixes: tag?

Otherwise:
Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

