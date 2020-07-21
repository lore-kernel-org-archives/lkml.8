Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A33C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E2220709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5qIpgFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgGULCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:02:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726266AbgGULCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595329351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Hd8mpjklFIL9BDw1lIZJpbTiG76n73CJj60X8HVXYI=;
        b=a5qIpgFpG0In8MdPeKIxXfu5KEMnzytOx1gTEDjscY8etXwr+PbGzsfskSmD7NwxK+eYR0
        q3YZ3F/iu7oYbGd5nAbHlzvn/vP6syP1ujxN/2SA8yMabihGmmEDDrJ+S89/k39WCCUnt0
        VGBkdPdZ5ts00QfcuH2sT30HRMQv2/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-HIHQZ2lqMGez3pIL7V5UNA-1; Tue, 21 Jul 2020 07:02:26 -0400
X-MC-Unique: HIHQZ2lqMGez3pIL7V5UNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CD4058;
        Tue, 21 Jul 2020 11:02:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CC7D10021B3;
        Tue, 21 Jul 2020 11:02:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CY4PR1101MB23267DC8D2B1232744A5D6DCE79B0@CY4PR1101MB2326.namprd11.prod.outlook.com>
References: <CY4PR1101MB23267DC8D2B1232744A5D6DCE79B0@CY4PR1101MB2326.namprd11.prod.outlook.com> <20200612183450.4189588-1-keescook@chromium.org> <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com> <202006142054.C00B3E9C9@keescook> <CY4PR1101MB23261B27ACF9D7FBC3969318E79C0@CY4PR1101MB2326.namprd11.prod.outlook.com> <202006151108.5B25D5A31@keescook>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     dhowells@redhat.com, Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "alex.huangjianhui@huawei.com" <alex.huangjianhui@huawei.com>,
        "dylix.dailei@huawei.com" <dylix.dailei@huawei.com>,
        "chenzefeng2@huawei.com" <chenzefeng2@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <546056.1595329339.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Jul 2020 12:02:19 +0100
Message-ID: <546057.1595329339@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> https://github.com/ereshetova/linux-stable/commits/refcount_t_fs

Looking at "fs, cachefiles: convert cachefiles_object.usage from atomic_t =
to
refcount_t", I see:

-	u =3D atomic_inc_return(&object->usage);
+	refcount_inc(&object->usage);
	trace_cachefiles_ref(object, _object->cookie,
-			     (enum cachefiles_obj_ref_trace)why, u);
+			     (enum cachefiles_obj_ref_trace)why, refcount_read(&object->usage)=
);
	return &object->fscache;

This change is *not* equivalent.  There's a reason I'm using
atomic_inc_return() and not atomic_inc(),atomic_read().  Yes, the small wi=
ndow
*does* occasionally produce incorrect tracing, and, yes, when that happens=
 it
does make things confusing.

-	u =3D atomic_dec_return(&object->usage);
	trace_cachefiles_ref(object, _object->cookie,
-			     (enum cachefiles_obj_ref_trace)why, u);
-	ASSERTCMP(u, !=3D, -1);
-	if (u =3D=3D 0) {
+			     (enum cachefiles_obj_ref_trace)why, refcount_read(&object->usage)=
 - 1);
+	if (refcount_dec_and_test(&object->usage)) {

This is also not equivalent.  Again, there's a reason I'm using
atomic_dec_return() and not atomic_read(),atomic_dec_and_test().

So, please drop the cachefiles/fscache patches or use refcount_inc_return(=
)
and refcount_dec_return().

Another reason to please drop these patches is that they will cause my
fscache-iter branch to bounce.  A lot of this code is deleted/heavily
rewritten:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dfscache-iter

Thanks,
David

