Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E1AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A3F2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LB5tR4Kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgAJPEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:04:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48214 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728174AbgAJPEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578668677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Si2zczaQ4B24l4I/KMqrXoy/jC0DLGxbZKyOpiSxhFg=;
        b=LB5tR4Kz+jt9N875hfjHKOjQhD28ys9l8Ts8wx/38ayJZicUZych/Z3fMMmxVLXROskZ4Z
        HVPChqIZB0KCbQYa1YCyjBJAqIvygugRMmn+8yUhaT+flANa3eHeW7c7mPWvXMystLkfbI
        ubBl6jXv3sd7ieJ/AixzXvUNhJXP0zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-Yuk5rVSHP9W0m6CF3Wsnyg-1; Fri, 10 Jan 2020 10:04:33 -0500
X-MC-Unique: Yuk5rVSHP9W0m6CF3Wsnyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44E1C107ACC5;
        Fri, 10 Jan 2020 15:04:31 +0000 (UTC)
Received: from krava (ovpn-205-164.brq.redhat.com [10.40.205.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A1535DA32;
        Fri, 10 Jan 2020 15:04:24 +0000 (UTC)
Date:   Fri, 10 Jan 2020 16:04:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v4 1/2] perf parse: Refactor struct perf_evsel_config_term
Message-ID: <20200110150422.GH82989@krava>
References: <20200108142010.11269-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108142010.11269-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 10:20:09PM +0800, Leo Yan wrote:
> The struct perf_evsel_config_term::val is a union which contains
> multiple variables for corresponding types.  This leads the union to
> be complex and also causes complex code logic.
>=20
> This patch refactors the structure to use two general variables in the
> 'val' union: one is 'num' for unsigned 64-bit integer and another is
> 'str' for string variable.  This can simplify the data structure and
> the related code, this also can benefit for possibly extension.
>=20
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

there's some arch code that needs to be changed.. please
change other archs as well


  CC       arch/x86/util/intel-pt.o
arch/x86/util/intel-pt.c: In function =E2=80=98intel_pt_config_sample_mod=
e=E2=80=99:
arch/x86/util/intel-pt.c:563:24: error: =E2=80=98union <anonymous>=E2=80=99=
 has no member named =E2=80=98cfg_chg=E2=80=99
  563 |   user_bits =3D term->val.cfg_chg;

thanks,
jirka

