Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70949C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3851C2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gB2ufWCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgBNM6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 07:58:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgBNM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581685082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCLwBU2AIrLiq97oVJcKrk3eBDD/n+Xy8GshU+OVGfo=;
        b=gB2ufWCGECpxOKgQUPDR6soK8q+RN6hhtb0XHMPWeu9CdOXzwOuJ6/EKOcSGFL2qsww+L3
        oKEr0ZETvyJMiuj4wjp3G4oT9zQtpf6H6a3Ai9PmR427RihGu7M3O7jj+kr76+W5nNLeYb
        RDdYn/cM94Pj9y/thHFu5UkkLOovHOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-zSDu1ixMO2OxRTz8M6LmzQ-1; Fri, 14 Feb 2020 07:57:58 -0500
X-MC-Unique: zSDu1ixMO2OxRTz8M6LmzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6160D13F8;
        Fri, 14 Feb 2020 12:57:57 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-10.phx2.redhat.com [10.3.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5B45DA7D;
        Fri, 14 Feb 2020 12:57:56 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 970F411E8; Fri, 14 Feb 2020 09:57:54 -0300 (BRT)
Date:   Fri, 14 Feb 2020 09:57:54 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     zhe.he@windriver.com
Cc:     rostedt@goodmis.org, tstoyanov@vmware.com, hewenliang4@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools lib traceevent: Take care of return value of
 asprintf
Message-ID: <20200214125754.GA2974@redhat.com>
References: <1581665486-20386-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581665486-20386-1-git-send-email-zhe.he@windriver.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 14, 2020 at 03:31:26PM +0800, zhe.he@windriver.com escreveu:
> From: He Zhe <zhe.he@windriver.com>
>=20
> According to the API, if memory allocation wasn't possible, or some oth=
er
> error occurs, asprintf will return -1, and the contents of strp below a=
re
> undefined.
>=20
> int asprintf(char **strp, const char *fmt, ...);
>=20
> This patch takes care of return value of asprintf to make it less error
> prone and prevent the following build warning.
>=20
> ignoring return value of =E2=80=98asprintf=E2=80=99, declared with attr=
ibute warn_unused_result [-Wunused-result]

Sure this fixes problems, but can you make it more compact, i.e. no need
to add most if not all those 'int ret;' lines, just check the asprintf
result directly, i.e.:

                             if (asprintf(&str, val ? "TRUE" : "FALSE") <=
 0)
                                     str =3D NULL;

saving the return value for that function is interesting when you need
to know how many bytes it printed to do some extra calculation, but if
all you need is to know if it failed, checking against < 0 is enough,
no?

- Arnaldo

=20
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/lib/traceevent/parse-filter.c | 42 +++++++++++++++++++++++++++++=
--------
>  1 file changed, 33 insertions(+), 9 deletions(-)
>=20
> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent=
/parse-filter.c
> index 20eed71..279b572 100644
> --- a/tools/lib/traceevent/parse-filter.c
> +++ b/tools/lib/traceevent/parse-filter.c
> @@ -1912,6 +1912,7 @@ static char *op_to_str(struct tep_event_filter *f=
ilter, struct tep_filter_arg *a
>  	int left_val =3D -1;
>  	int right_val =3D -1;
>  	int val;
> +	int ret;
> =20
>  	switch (arg->op.type) {
>  	case TEP_FILTER_OP_AND:
> @@ -1958,7 +1959,9 @@ static char *op_to_str(struct tep_event_filter *f=
ilter, struct tep_filter_arg *a
>  				default:
>  					break;
>  				}
> -				asprintf(&str, val ? "TRUE" : "FALSE");
> +				ret =3D asprintf(&str, val ? "TRUE" : "FALSE");
> +				if (ret < 0)
> +					str =3D NULL;
>  				break;
>  			}
>  		}
> @@ -1976,7 +1979,9 @@ static char *op_to_str(struct tep_event_filter *f=
ilter, struct tep_filter_arg *a
>  			break;
>  		}
> =20
> -		asprintf(&str, "(%s) %s (%s)", left, op, right);
> +		ret =3D asprintf(&str, "(%s) %s (%s)", left, op, right);
> +		if (ret < 0)
> +			str =3D NULL;
>  		break;
> =20
>  	case TEP_FILTER_OP_NOT:
> @@ -1992,10 +1997,14 @@ static char *op_to_str(struct tep_event_filter =
*filter, struct tep_filter_arg *a
>  			right_val =3D 0;
>  		if (right_val >=3D 0) {
>  			/* just return the opposite */
> -			asprintf(&str, right_val ? "FALSE" : "TRUE");
> +			ret =3D asprintf(&str, right_val ? "FALSE" : "TRUE");
> +			if (ret < 0)
> +				str =3D NULL;
>  			break;
>  		}
> -		asprintf(&str, "%s(%s)", op, right);
> +		ret =3D asprintf(&str, "%s(%s)", op, right);
> +		if (ret < 0)
> +			str =3D NULL;
>  		break;
> =20
>  	default:
> @@ -2010,8 +2019,11 @@ static char *op_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *a
>  static char *val_to_str(struct tep_event_filter *filter, struct tep_fi=
lter_arg *arg)
>  {
>  	char *str =3D NULL;
> +	int ret;
> =20
> -	asprintf(&str, "%lld", arg->value.val);
> +	ret =3D asprintf(&str, "%lld", arg->value.val);
> +	if (ret < 0)
> +		str =3D NULL;
> =20
>  	return str;
>  }
> @@ -2027,6 +2039,7 @@ static char *exp_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
>  	char *rstr;
>  	char *op;
>  	char *str =3D NULL;
> +	int ret;
> =20
>  	lstr =3D arg_to_str(filter, arg->exp.left);
>  	rstr =3D arg_to_str(filter, arg->exp.right);
> @@ -2069,7 +2082,9 @@ static char *exp_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
>  		break;
>  	}
> =20
> -	asprintf(&str, "%s %s %s", lstr, op, rstr);
> +	ret =3D asprintf(&str, "%s %s %s", lstr, op, rstr);
> +	if (ret < 0)
> +		str =3D NULL;
>  out:
>  	free(lstr);
>  	free(rstr);
> @@ -2083,6 +2098,7 @@ static char *num_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
>  	char *rstr;
>  	char *str =3D NULL;
>  	char *op =3D NULL;
> +	int ret;
> =20
>  	lstr =3D arg_to_str(filter, arg->num.left);
>  	rstr =3D arg_to_str(filter, arg->num.right);
> @@ -2113,7 +2129,9 @@ static char *num_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
>  		if (!op)
>  			op =3D "<=3D";
> =20
> -		asprintf(&str, "%s %s %s", lstr, op, rstr);
> +		ret =3D asprintf(&str, "%s %s %s", lstr, op, rstr);
> +		if (ret < 0)
> +			str =3D NULL;
>  		break;
> =20
>  	default:
> @@ -2131,6 +2149,7 @@ static char *str_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
>  {
>  	char *str =3D NULL;
>  	char *op =3D NULL;
> +	int ret;
> =20
>  	switch (arg->str.type) {
>  	case TEP_FILTER_CMP_MATCH:
> @@ -2148,8 +2167,10 @@ static char *str_to_str(struct tep_event_filter =
*filter, struct tep_filter_arg *
>  		if (!op)
>  			op =3D "!~";
> =20
> -		asprintf(&str, "%s %s \"%s\"",
> +		ret =3D asprintf(&str, "%s %s \"%s\"",
>  			 arg->str.field->name, op, arg->str.val);
> +		if (ret < 0)
> +			str =3D NULL;
>  		break;
> =20
>  	default:
> @@ -2162,10 +2183,13 @@ static char *str_to_str(struct tep_event_filter=
 *filter, struct tep_filter_arg *
>  static char *arg_to_str(struct tep_event_filter *filter, struct tep_fi=
lter_arg *arg)
>  {
>  	char *str =3D NULL;
> +	int ret;
> =20
>  	switch (arg->type) {
>  	case TEP_FILTER_ARG_BOOLEAN:
> -		asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
> +		ret =3D asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
> +		if (ret < 0)
> +			str =3D NULL;
>  		return str;
> =20
>  	case TEP_FILTER_ARG_OP:
> --=20
> 2.7.4

