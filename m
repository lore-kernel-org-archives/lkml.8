Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56811C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1EC208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597945498;
	bh=1LTG7wxuOSyUcGsjQvDYsQUoSMtu88q6TZ40k5pqdzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2bSJdQdgCW24kByEtL1y5BnplPhPQ6Cb1Ldjuj+3HMP80cDDAik3yE4DPtaLFckdV
	 WLoSqNhtI9xy0K5kfBG1Fxndr1CgiCnb6aciiqwE0QIkx8iE2Kv43Ym7nxs0WCLVGi
	 5HxW3v0pfthrK4wPkfyb1aVOFpfhq5pD3YlF6C7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHTRoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:44:55 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:41828 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgHTRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:44:48 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 07KHhX9r017281;
        Fri, 21 Aug 2020 02:43:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 07KHhX9r017281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597945414;
        bh=WpE+4tvygXdwrHE7yFSYKoEyq34/V7cNx79leKF6YBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8mDpU4tJ8BDgiTAgtgVsAzgt0Y0wc9340fY6mf0rHWaMLmNIBNrZFufwrY7OjfBs
         f/7aPXtXjvviIez9LgYVHuVyxVxileJiZwJ7Q/r6kW0q57ThP/VHA9EWD6zJv7QdyS
         SbcXZUteSvBdgFIBQrNpAZf3bFGMvIP7DofTAOIBuQ+xmtSvp9ZjqZpD5V5yoRVKig
         GPvedf7NpwfjH3ESd/86QVYcM2iPGhiZXmVJlexg+rDPzfrLesKInCpP+JlUHRWpI2
         /qUEEfBDDCY4dPgvH+3xo5ZHSePU3inMeF32PH8RTWyKpBlKb7/aO+ln7apBoXQOV4
         5A1sSYbN5CwpQ==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Robert Crawford <flacycads@cox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kconfig: qconf: replace depreacated QString::sprintf() with QTextStream
Date:   Fri, 21 Aug 2020 02:43:28 +0900
Message-Id: <20200820174328.490374-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820174328.490374-1-masahiroy@kernel.org>
References: <20200820174328.490374-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QString::sprintf() is deprecated in the latest Qt version, and spawns
a lot of warnings:

  HOSTCXX scripts/kconfig/qconf.o
scripts/kconfig/qconf.cc: In member function ‘void ConfigInfoView::menuInfo()’:
scripts/kconfig/qconf.cc:1090:61: warning: ‘QString& QString::sprintf(const char*, ...)’ is deprecated: Use asprintf(), arg() or QTextStream instead [-Wdeprecated-declarations]
 1090 |      head += QString().sprintf("<a href=\"s%s\">", sym->name);
      |                                                             ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                 from /usr/include/qt5/QtWidgets/qaction.h:44,
                 from /usr/include/qt5/QtWidgets/QAction:1,
                 from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
  382 |     QString &sprintf(const char *format, ...) Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
      |              ^~~~~~~
scripts/kconfig/qconf.cc:1099:60: warning: ‘QString& QString::sprintf(const char*, ...)’ is deprecated: Use asprintf(), arg() or QTextStream instead [-Wdeprecated-declarations]
 1099 |     head += QString().sprintf("<a href=\"s%s\">", sym->name);
      |                                                            ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                 from /usr/include/qt5/QtWidgets/qaction.h:44,
                 from /usr/include/qt5/QtWidgets/QAction:1,
                 from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
  382 |     QString &sprintf(const char *format, ...) Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
      |              ^~~~~~~
scripts/kconfig/qconf.cc:1127:90: warning: ‘QString& QString::sprintf(const char*, ...)’ is deprecated: Use asprintf(), arg() or QTextStream instead [-Wdeprecated-declarations]
 1127 |   debug += QString().sprintf("defined at %s:%d<br><br>", _menu->file->name, _menu->lineno);
      |                                                                                          ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                 from /usr/include/qt5/QtWidgets/qaction.h:44,
                 from /usr/include/qt5/QtWidgets/QAction:1,
                 from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
  382 |     QString &sprintf(const char *format, ...) Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
      |              ^~~~~~~
scripts/kconfig/qconf.cc: In member function ‘QString ConfigInfoView::debug_info(symbol*)’:
scripts/kconfig/qconf.cc:1150:68: warning: ‘QString& QString::sprintf(const char*, ...)’ is deprecated: Use asprintf(), arg() or QTextStream instead [-Wdeprecated-declarations]
 1150 |    debug += QString().sprintf("prompt: <a href=\"m%s\">", sym->name);
      |                                                                    ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                 from /usr/include/qt5/QtWidgets/qaction.h:44,
                 from /usr/include/qt5/QtWidgets/QAction:1,
                 from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
  382 |     QString &sprintf(const char *format, ...) Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
      |              ^~~~~~~
scripts/kconfig/qconf.cc: In static member function ‘static void ConfigInfoView::expr_print_help(void*, symbol*, const char*)’:
scripts/kconfig/qconf.cc:1225:59: warning: ‘QString& QString::sprintf(const char*, ...)’ is deprecated: Use asprintf(), arg() or QTextStream instead [-Wdeprecated-declarations]
 1225 |   *text += QString().sprintf("<a href=\"s%s\">", sym->name);
      |                                                           ^
In file included from /usr/include/qt5/QtGui/qkeysequence.h:44,
                 from /usr/include/qt5/QtWidgets/qaction.h:44,
                 from /usr/include/qt5/QtWidgets/QAction:1,
                 from scripts/kconfig/qconf.cc:7:
/usr/include/qt5/QtCore/qstring.h:382:14: note: declared here
  382 |     QString &sprintf(const char *format, ...) Q_ATTRIBUTE_FORMAT_PRINTF(2, 3);
      |              ^~~~~~~

The documentation also says:
"Warning: We do not recommend using QString::asprintf() in new Qt code.
Instead, consider using QTextStream or arg(), both of which support
Unicode strings seamlessly and are type-safe."

Do as suggested.

Reported-by: Robert Crawford <flacycads@cox.net>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 116 +++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 54 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 4c5688a845f8..8638785328a7 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1076,75 +1076,80 @@ void ConfigInfoView::symbolInfo(void)
 void ConfigInfoView::menuInfo(void)
 {
 	struct symbol* sym;
-	QString head, debug, help;
+	QString info;
+	QTextStream stream(&info);
 
 	sym = _menu->sym;
 	if (sym) {
 		if (_menu->prompt) {
-			head += "<big><b>";
-			head += print_filter(_menu->prompt->text);
-			head += "</b></big>";
+			stream << "<big><b>";
+			stream << print_filter(_menu->prompt->text);
+			stream << "</b></big>";
 			if (sym->name) {
-				head += " (";
+				stream << " (";
 				if (showDebug())
-					head += QString().sprintf("<a href=\"s%s\">", sym->name);
-				head += print_filter(sym->name);
+					stream << "<a href=\"s" << sym->name << "\">";
+				stream << print_filter(sym->name);
 				if (showDebug())
-					head += "</a>";
-				head += ")";
+					stream << "</a>";
+				stream << ")";
 			}
 		} else if (sym->name) {
-			head += "<big><b>";
+			stream << "<big><b>";
 			if (showDebug())
-				head += QString().sprintf("<a href=\"s%s\">", sym->name);
-			head += print_filter(sym->name);
+				stream << "<a href=\"s" << sym->name << "\">";
+			stream << print_filter(sym->name);
 			if (showDebug())
-				head += "</a>";
-			head += "</b></big>";
+				stream << "</a>";
+			stream << "</b></big>";
 		}
-		head += "<br><br>";
+		stream << "<br><br>";
 
 		if (showDebug())
-			debug = debug_info(sym);
+			stream << debug_info(sym);
+
 	} else if (_menu->prompt) {
-		head += "<big><b>";
-		head += print_filter(_menu->prompt->text);
-		head += "</b></big><br><br>";
+		stream << "<big><b>";
+		stream << print_filter(_menu->prompt->text);
+		stream << "</b></big><br><br>";
 		if (showDebug()) {
 			if (_menu->prompt->visible.expr) {
-				debug += "&nbsp;&nbsp;dep: ";
-				expr_print(_menu->prompt->visible.expr, expr_print_help, &debug, E_NONE);
-				debug += "<br><br>";
+				stream << "&nbsp;&nbsp;dep: ";
+				expr_print(_menu->prompt->visible.expr,
+					   expr_print_help, &stream, E_NONE);
+				stream << "<br><br>";
 			}
 		}
 	}
 	if (showDebug())
-		debug += QString().sprintf("defined at %s:%d<br><br>", _menu->file->name, _menu->lineno);
+		stream << "defined at " << _menu->file->name << ":"
+		       << _menu->lineno << "<br><br>";
 
-	setText(head + debug);
+	setText(info);
 }
 
 QString ConfigInfoView::debug_info(struct symbol *sym)
 {
 	QString debug;
+	QTextStream stream(&debug);
 
-	debug += "type: ";
-	debug += print_filter(sym_type_name(sym->type));
+	stream << "type: ";
+	stream << print_filter(sym_type_name(sym->type));
 	if (sym_is_choice(sym))
-		debug += " (choice)";
+		stream << " (choice)";
 	debug += "<br>";
 	if (sym->rev_dep.expr) {
-		debug += "reverse dep: ";
-		expr_print(sym->rev_dep.expr, expr_print_help, &debug, E_NONE);
-		debug += "<br>";
+		stream << "reverse dep: ";
+		expr_print(sym->rev_dep.expr, expr_print_help, &stream, E_NONE);
+		stream << "<br>";
 	}
 	for (struct property *prop = sym->prop; prop; prop = prop->next) {
 		switch (prop->type) {
 		case P_PROMPT:
 		case P_MENU:
-			debug += QString().sprintf("prompt: <a href=\"m%s\">", sym->name);
-			debug += print_filter(prop->text);
-			debug += "</a><br>";
+			stream << "prompt: <a href=\"m" << sym->name << "\">";
+			stream << print_filter(prop->text);
+			stream << "</a><br>";
 			break;
 		case P_DEFAULT:
 		case P_SELECT:
@@ -1152,30 +1157,33 @@ QString ConfigInfoView::debug_info(struct symbol *sym)
 		case P_COMMENT:
 		case P_IMPLY:
 		case P_SYMBOL:
-			debug += prop_get_type_name(prop->type);
-			debug += ": ";
-			expr_print(prop->expr, expr_print_help, &debug, E_NONE);
-			debug += "<br>";
+			stream << prop_get_type_name(prop->type);
+			stream << ": ";
+			expr_print(prop->expr, expr_print_help,
+				   &stream, E_NONE);
+			stream << "<br>";
 			break;
 		case P_CHOICE:
 			if (sym_is_choice(sym)) {
-				debug += "choice: ";
-				expr_print(prop->expr, expr_print_help, &debug, E_NONE);
-				debug += "<br>";
+				stream << "choice: ";
+				expr_print(prop->expr, expr_print_help,
+					   &stream, E_NONE);
+				stream << "<br>";
 			}
 			break;
 		default:
-			debug += "unknown property: ";
-			debug += prop_get_type_name(prop->type);
-			debug += "<br>";
+			stream << "unknown property: ";
+			stream << prop_get_type_name(prop->type);
+			stream << "<br>";
 		}
 		if (prop->visible.expr) {
-			debug += "&nbsp;&nbsp;&nbsp;&nbsp;dep: ";
-			expr_print(prop->visible.expr, expr_print_help, &debug, E_NONE);
-			debug += "<br>";
+			stream << "&nbsp;&nbsp;&nbsp;&nbsp;dep: ";
+			expr_print(prop->visible.expr, expr_print_help,
+				   &stream, E_NONE);
+			stream << "<br>";
 		}
 	}
-	debug += "<br>";
+	stream << "<br>";
 
 	return debug;
 }
@@ -1213,15 +1221,15 @@ QString ConfigInfoView::print_filter(const QString &str)
 
 void ConfigInfoView::expr_print_help(void *data, struct symbol *sym, const char *str)
 {
-	QString* text = reinterpret_cast<QString*>(data);
-	QString str2 = print_filter(str);
+	QTextStream *stream = reinterpret_cast<QTextStream *>(data);
 
 	if (sym && sym->name && !(sym->flags & SYMBOL_CONST)) {
-		*text += QString().sprintf("<a href=\"s%s\">", sym->name);
-		*text += str2;
-		*text += "</a>";
-	} else
-		*text += str2;
+		*stream << "<a href=\"s" << sym->name << "\">";
+		*stream << print_filter(str);
+		*stream << "</a>";
+	} else {
+		*stream << print_filter(str);
+	}
 }
 
 void ConfigInfoView::clicked(const QUrl &url)
-- 
2.25.1

