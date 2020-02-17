Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94083C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B6D206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBDQd+EJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgBQPxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:53:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727553AbgBQPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581954813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hK174jLcgCzglxyqUNBzlo58n2x9vh0u6ToVztNUsHM=;
        b=DBDQd+EJJFrjWeWZkQsyEcVgncCReHRaZKHu6mJdC15QguyaJQQf3rAzgXrPg+nohoD7+H
        /c1MQrC7uTRjt3fTzBDMCgXrw33h+mmvORzIMqT6+Da/uMAK8iYuYTv3zWpCzE4IOuyCv+
        yN9Lx2vDnabias5v6mNduUalKg5Vw3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-cmm_RmBkMZedosySOnEz-Q-1; Mon, 17 Feb 2020 10:53:29 -0500
X-MC-Unique: cmm_RmBkMZedosySOnEz-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FAFA107ACC5;
        Mon, 17 Feb 2020 15:53:28 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-26.phx2.redhat.com [10.3.112.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25CB919C69;
        Mon, 17 Feb 2020 15:53:27 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id C5472244; Mon, 17 Feb 2020 12:53:23 -0300 (BRT)
Date:   Mon, 17 Feb 2020 12:53:23 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>, zhe.he@windriver.com
Cc:     rostedt@goodmis.org, tstoyanov@vmware.com, hewenliang4@huawei.com,
        linux-kernel@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH v2] tools lib traceevent: Take care of return value of
 asprintf
Message-ID: <20200217155323.GB3538@redhat.com>
References: <1581686481-180476-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581686481-180476-1-git-send-email-zhe.he@windriver.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 14, 2020 at 09:21:21PM +0800, zhe.he@windriver.com escreveu:
> From: He Zhe <zhe.he@windriver.com>
>=20
> According to the API, if memory allocation wasn't possible, or some oth=
er
> error occurs, asprintf will return -1, and the contents of strp below a=
re
> undefined.

Rostedt, did I miss some ack from you?

- Arnaldo
=20
> int asprintf(char **strp, const char *fmt, ...);
>=20
> This patch takes care of return value of asprintf to make it less error
> prone and prevent the following build warning.
>=20
> ignoring return value of =E2=80=98asprintf=E2=80=99, declared with attr=
ibute warn_unused_result [-Wunused-result]
>=20
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2: directly check the return value without saving to a variable
>=20
>  tools/lib/traceevent/parse-filter.c | 35 +++++++++++++++++++++--------=
------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>=20
> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent=
/parse-filter.c
> index 20eed71..6cd0228 100644
> --- a/tools/lib/traceevent/parse-filter.c
> +++ b/tools/lib/traceevent/parse-filter.c
> @@ -274,8 +274,7 @@ find_event(struct tep_handle *tep, struct event_lis=
t **events,
>  		sys_name =3D NULL;
>  	}
> =20
> -	ret =3D asprintf(&reg, "^%s$", event_name);
> -	if (ret < 0)
> +	if (asprintf(&reg, "^%s$", event_name) < 0)
>  		return TEP_ERRNO__MEM_ALLOC_FAILED;
> =20
>  	ret =3D regcomp(&ereg, reg, REG_ICASE|REG_NOSUB);
> @@ -285,8 +284,7 @@ find_event(struct tep_handle *tep, struct event_lis=
t **events,
>  		return TEP_ERRNO__INVALID_EVENT_NAME;
> =20
>  	if (sys_name) {
> -		ret =3D asprintf(&reg, "^%s$", sys_name);
> -		if (ret < 0) {
> +		if (asprintf(&reg, "^%s$", sys_name) < 0) {
>  			regfree(&ereg);
>  			return TEP_ERRNO__MEM_ALLOC_FAILED;
>  		}
> @@ -1958,7 +1956,8 @@ static char *op_to_str(struct tep_event_filter *f=
ilter, struct tep_filter_arg *a
>  				default:
>  					break;
>  				}
> -				asprintf(&str, val ? "TRUE" : "FALSE");
> +				if (asprintf(&str, val ? "TRUE" : "FALSE") < 0)
> +					str =3D NULL;
>  				break;
>  			}
>  		}
> @@ -1976,7 +1975,8 @@ static char *op_to_str(struct tep_event_filter *f=
ilter, struct tep_filter_arg *a
>  			break;
>  		}
> =20
> -		asprintf(&str, "(%s) %s (%s)", left, op, right);
> +		if (asprintf(&str, "(%s) %s (%s)", left, op, right) < 0)
> +			str =3D NULL;
>  		break;
> =20
>  	case TEP_FILTER_OP_NOT:
> @@ -1992,10 +1992,12 @@ static char *op_to_str(struct tep_event_filter =
*filter, struct tep_filter_arg *a
>  			right_val =3D 0;
>  		if (right_val >=3D 0) {
>  			/* just return the opposite */
> -			asprintf(&str, right_val ? "FALSE" : "TRUE");
> +			if (asprintf(&str, right_val ? "FALSE" : "TRUE") < 0)
> +				str =3D NULL;
>  			break;
>  		}
> -		asprintf(&str, "%s(%s)", op, right);
> +		if (asprintf(&str, "%s(%s)", op, right) < 0)
> +			str =3D NULL;
>  		break;
> =20
>  	default:
> @@ -2011,7 +2013,8 @@ static char *val_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
>  {
>  	char *str =3D NULL;
> =20
> -	asprintf(&str, "%lld", arg->value.val);
> +	if (asprintf(&str, "%lld", arg->value.val) < 0)
> +		str =3D NULL;
> =20
>  	return str;
>  }
> @@ -2069,7 +2072,8 @@ static char *exp_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
>  		break;
>  	}
> =20
> -	asprintf(&str, "%s %s %s", lstr, op, rstr);
> +	if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
> +		str =3D NULL;
>  out:
>  	free(lstr);
>  	free(rstr);
> @@ -2113,7 +2117,8 @@ static char *num_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
>  		if (!op)
>  			op =3D "<=3D";
> =20
> -		asprintf(&str, "%s %s %s", lstr, op, rstr);
> +		if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
> +			str =3D NULL;
>  		break;
> =20
>  	default:
> @@ -2148,8 +2153,9 @@ static char *str_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
>  		if (!op)
>  			op =3D "!~";
> =20
> -		asprintf(&str, "%s %s \"%s\"",
> -			 arg->str.field->name, op, arg->str.val);
> +		if (asprintf(&str, "%s %s \"%s\"",
> +			 arg->str.field->name, op, arg->str.val) < 0)
> +			str =3D NULL;
>  		break;
> =20
>  	default:
> @@ -2165,7 +2171,8 @@ static char *arg_to_str(struct tep_event_filter *=
filter, struct tep_filter_arg *
> =20
>  	switch (arg->type) {
>  	case TEP_FILTER_ARG_BOOLEAN:
> -		asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
> +		if (asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE") < 0)
> +			str =3D NULL;
>  		return str;
> =20
>  	case TEP_FILTER_ARG_OP:
> --=20
> 2.7.4

