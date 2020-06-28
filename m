Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815D7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56369207E8
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIwk/8UR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgF1M0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 08:26:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44152 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726317AbgF1M0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 08:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593347162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1W+PDeIPGAecCjGuTwQ4SNo4Mx5862t73hY8MDCvgU=;
        b=FIwk/8URf3Cs/NJEfu7D5UbO28+6wvN/0GiALd/Xf23fX5nA/svvywh2dwxfCr/952pA3l
        NYwuVhRMpr622USUV1FX7zV1brYT6d9JomBLjqXGUAwlZsUuRYEcMmibb3tb/vDBLGSeMP
        MA+TyCIbJHhGTDPW5COiojCPHyYT4cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-4UCH2FU0PXeNZzYjKBciqA-1; Sun, 28 Jun 2020 08:25:58 -0400
X-MC-Unique: 4UCH2FU0PXeNZzYjKBciqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40A80107ACCD;
        Sun, 28 Jun 2020 12:25:57 +0000 (UTC)
Received: from starship (unknown [10.35.206.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBA051C8;
        Sun, 28 Jun 2020 12:25:55 +0000 (UTC)
Message-ID: <256d2ebde769673d53441d777531964ad9468835.camel@redhat.com>
Subject: Re: [PATCH] kconfig: qconf: make debug links work again
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 28 Jun 2020 15:25:54 +0300
In-Reply-To: <ff9d1c3369b96c1d14b1e898e3d5f64ad945b604.1593346883.git.mchehab+huawei@kernel.org>
References: <ff9d1c3369b96c1d14b1e898e3d5f64ad945b604.1593346883.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-28 at 14:21 +0200, Mauro Carvalho Chehab wrote:
> The Qt5 conversion broke support for debug info links.
> 
> Restore the behaviour added by changeset
> ab45d190fd4a ("kconfig: create links in info window").
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/kconfig/qconf.cc | 35 ++++++++++++++++++++++++++++++++++-
>  scripts/kconfig/qconf.h  |  1 +
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
> index 631e19659504..03cadf27a376 100644
> --- a/scripts/kconfig/qconf.cc
> +++ b/scripts/kconfig/qconf.cc
> @@ -1012,7 +1012,7 @@ ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
>  	: Parent(parent), sym(0), _menu(0)
>  {
>  	setObjectName(name);
> -
> +	setOpenLinks(false);
>  
>  	if (!objectName().isEmpty()) {
>  		configSettings->beginGroup(objectName());
> @@ -1224,6 +1224,36 @@ void ConfigInfoView::expr_print_help(void *data, struct symbol *sym, const char
>  		*text += str2;
>  }
>  
> +void ConfigInfoView::clicked(const QUrl &url)
> +{
> +	QByteArray str = url.toEncoded();
> +	const std::size_t count = str.size();
> +	char *hex = new char[count];
> +	unsigned long p;
> +
> +	if (count < 1)
> +		return;
> +
> +	memcpy(hex, str.constData(), count);
> +	p = (int)strtol(hex + 1, NULL, 16);
> +
> +	if (!p)
> +		return;
> +
> +	if (hex[0] == 's') {
> +		struct symbol *s = (struct symbol *)p;
> +
> +		sym = s;
> +		symbolInfo();
> +	} else {
> +		struct menu *m = (struct menu *)p;
> +
> +		_menu = m;
> +		menuInfo();
> +	}
> +	emit showDebugChanged(true);
> +}
> +
>  QMenu* ConfigInfoView::createStandardContextMenu(const QPoint & pos)
>  {
>  	QMenu* popup = Parent::createStandardContextMenu(pos);
> @@ -1497,6 +1527,9 @@ ConfigMainWindow::ConfigMainWindow(void)
>  	helpMenu->addAction(showIntroAction);
>  	helpMenu->addAction(showAboutAction);
>  
> +	connect (helpText, SIGNAL (anchorClicked (const QUrl &)),
> +		 helpText, SLOT (clicked (const QUrl &)) );
> +
>  	connect(configList, SIGNAL(menuChanged(struct menu *)),
>  		helpText, SLOT(setInfo(struct menu *)));
>  	connect(configList, SIGNAL(menuSelected(struct menu *)),
> diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
> index d913a02967ae..a193137f2314 100644
> --- a/scripts/kconfig/qconf.h
> +++ b/scripts/kconfig/qconf.h
> @@ -250,6 +250,7 @@ public slots:
>  	void setInfo(struct menu *menu);
>  	void saveSettings(void);
>  	void setShowDebug(bool);
> +	void clicked (const QUrl &url);
>  
>  signals:
>  	void showDebugChanged(bool);

Just tested it and it works well. Thank you very much!

Best regards,
	Maxim Levitsky

