Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9AFC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E2C20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwePlZ2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgCQPJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:09:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25769 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgCQPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584457797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8iILvFH/Hh45WwWd2Tll4O2HS3c9EOcQluJDAT1Tvs=;
        b=WwePlZ2mdEftUcL3KKvHGj6t24XAlgOwRbIoHz02rEnBQyVrYOC9N7igAbzURDcnC711G+
        n0685M8BUMIIyggbwkdqeoYEMabHd+ODifQUc5SQiOrW/o0YkRSsvkb5U1kcHhBTnUYr6l
        dFDDa0v8htZAscdBLOdv8eegR7RAG+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-umzcRsxPNaGg6J9B0q9hpA-1; Tue, 17 Mar 2020 11:09:56 -0400
X-MC-Unique: umzcRsxPNaGg6J9B0q9hpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C8E0A1366;
        Tue, 17 Mar 2020 15:09:53 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1138D5D9E5;
        Tue, 17 Mar 2020 15:09:47 +0000 (UTC)
Date:   Tue, 17 Mar 2020 16:09:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 08/11] perf/tools: Refactoring metricgroup__add_metric
 function
Message-ID: <20200317150945.GC757893@krava>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-9-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317062333.14555-9-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:53:30AM +0530, Kajol Jain wrote:
> This patch refactor metricgroup__add_metric function where
> some part of it move to function metricgroup__add_metric_param.
> No logic change.

can't compile this change:

[jolsa@krava perf]$ make JOBS=3D1
  BUILD:   Doing 'make -j1' parallel build
  CC       util/metricgroup.o
util/metricgroup.c: In function =E2=80=98metricgroup__add_metric_param=E2=
=80=99:
util/metricgroup.c:486:6: error: too many arguments to function =E2=80=98=
expr__find_other=E2=80=99
  486 |  if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum, 1) < 0=
)
      |      ^~~~~~~~~~~~~~~~
In file included from util/metricgroup.c:14:
util/expr.h:25:5: note: declared here
   25 | int expr__find_other(const char *expr, const char *one, const cha=
r ***other,
      |     ^~~~~~~~~~~~~~~~
mv: cannot stat 'util/.metricgroup.o.tmp': No such file or directory
make[4]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:97=
: util/metricgroup.o] Error 1
make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:13=
9: util] Error 2
make[2]: *** [Makefile.perf:616: perf-in.o] Error 2
make[1]: *** [Makefile.perf:225: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

jirka

>=20
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/util/metricgroup.c | 63 +++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 25 deletions(-)
>=20
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> index c3a8c701609a..b4919bcfbd8b 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -474,6 +474,41 @@ static bool metricgroup__has_constraint(struct pmu=
_event *pe)
>  	return false;
>  }
> =20
> +static int metricgroup__add_metric_param(struct strbuf *events,
> +			struct list_head *group_list, struct pmu_event *pe)
> +{
> +
> +	const char **ids;
> +	int idnum;
> +	struct egroup *eg;
> +	int ret =3D -EINVAL;
> +
> +	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum, 1) < 0)
> +		return ret;
> +
> +	if (events->len > 0)
> +		strbuf_addf(events, ",");
> +
> +	if (metricgroup__has_constraint(pe))
> +		metricgroup__add_metric_non_group(events, ids, idnum);
> +	else
> +		metricgroup__add_metric_weak_group(events, ids, idnum);
> +
> +	eg =3D malloc(sizeof(*eg));
> +	if (!eg)
> +		ret =3D -ENOMEM;
> +
> +	eg->ids =3D ids;
> +	eg->idnum =3D idnum;
> +	eg->metric_name =3D pe->metric_name;
> +	eg->metric_expr =3D pe->metric_expr;
> +	eg->metric_unit =3D pe->unit;
> +	list_add_tail(&eg->nd, group_list);
> +	ret =3D 0;
> +
> +	return ret;
> +}
> +
>  static int metricgroup__add_metric(const char *metric, struct strbuf *=
events,
>  				   struct list_head *group_list)
>  {
> @@ -493,35 +528,13 @@ static int metricgroup__add_metric(const char *me=
tric, struct strbuf *events,
>  			continue;
>  		if (match_metric(pe->metric_group, metric) ||
>  		    match_metric(pe->metric_name, metric)) {
> -			const char **ids;
> -			int idnum;
> -			struct egroup *eg;
> =20
>  			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_nam=
e);
> =20
> -			if (expr__find_other(pe->metric_expr,
> -					     NULL, &ids, &idnum) < 0)
> +			ret =3D metricgroup__add_metric_param(events,
> +							group_list, pe);
> +			if (ret =3D=3D -EINVAL)
>  				continue;
> -			if (events->len > 0)
> -				strbuf_addf(events, ",");
> -
> -			if (metricgroup__has_constraint(pe))
> -				metricgroup__add_metric_non_group(events, ids, idnum);
> -			else
> -				metricgroup__add_metric_weak_group(events, ids, idnum);
> -
> -			eg =3D malloc(sizeof(struct egroup));
> -			if (!eg) {
> -				ret =3D -ENOMEM;
> -				break;
> -			}
> -			eg->ids =3D ids;
> -			eg->idnum =3D idnum;
> -			eg->metric_name =3D pe->metric_name;
> -			eg->metric_expr =3D pe->metric_expr;
> -			eg->metric_unit =3D pe->unit;
> -			list_add_tail(&eg->nd, group_list);
> -			ret =3D 0;
>  		}
>  	}
>  	return ret;
> --=20
> 2.18.1
>=20

