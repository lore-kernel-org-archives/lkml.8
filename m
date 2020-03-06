Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A3C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5CF2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWIQnRNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFJjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:39:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29842 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726025AbgCFJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583487593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9w4K7HNHCcCnQl8kwABMmkKSWRS3bVzaaYz6cJNs38g=;
        b=XWIQnRNbuIXtzQL0SxFjgNCm7tGRIzpkxFPFEzsdMUsPdMZZ9hc5NxI2sYxLFw5UsbRrTw
        7np92TAZSDikjS+5R1Q1awkulSXEoXlbEOuc05LP6/hdJXfFz9ePv7dyNBhdb62mazDxCn
        Wf0/Z2YWJSnCkKFJPCR1Z/dPqVuJ5uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-eoz86C1CN02ZFquzgDPX9A-1; Fri, 06 Mar 2020 04:39:49 -0500
X-MC-Unique: eoz86C1CN02ZFquzgDPX9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 973B3107ACC7;
        Fri,  6 Mar 2020 09:39:47 +0000 (UTC)
Received: from krava (ovpn-205-205.brq.redhat.com [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2C0019756;
        Fri,  6 Mar 2020 09:39:43 +0000 (UTC)
Date:   Fri, 6 Mar 2020 10:39:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH 00/12] Stitch LBR call stack (Perf Tools)
Message-ID: <20200306093940.GD281906@krava>
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200228163011.19358-1-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 08:29:59AM -0800, kan.liang@linux.intel.com wrote=
:

SNIP

> Kan Liang (12):
>   perf tools: Add hw_idx in struct branch_stack
>   perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
>   perf header: Add check for event attr
>   perf pmu: Add support for PMU capabilities

hi,
I'm getting compile error:

	util/pmu.c: In function =E2=80=98perf_pmu__caps_parse=E2=80=99:
	util/pmu.c:1620:32: error: =E2=80=98%s=E2=80=99 directive output may be =
truncated writing up to 255 bytes into a region of size between 0 and 409=
5 [-Werror=3Dformat-truncation=3D]
	 1620 |   snprintf(path, PATH_MAX, "%s/%s", caps_path, name);
	      |                                ^~
	In file included from /usr/include/stdio.h:867,
			 from util/pmu.c:12:
	/usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprintf_ch=
k=E2=80=99 output between 2 and 4352 bytes into a destination of size 409=
6
	   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL=
 - 1,
	      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
	   68 |        __bos (__s), __fmt, __va_arg_pack ());
	      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	cc1: all warnings being treated as errors

	[jolsa@krava perf]$ gcc --version
	gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1)

jirka

