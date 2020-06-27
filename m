Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0175C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B962321883
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxJ8Vm0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgF0PTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:19:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25698 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbgF0PTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 11:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593271149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=lLnMJWHmIIaez/cwbbINRXMtLt9cU4syfqc1EMj2/3M=;
        b=AxJ8Vm0df5/qN4qZa5xLdg/AVFWS/WcxX3njni8/fKvRLnLpPMPliAU2dcCvMO7gBHEGa1
        6MSMd3HecHKEXrx7omlljcmVWPr/VDzlBMO4JAqhuYvH+Ze+8GBCcD8NwwJTwSODPm2ETm
        wM0BHpfcbDtgJpai5EUJWOTfOHR9Sig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-guPSaE21MKWlSW1fgjZ1RA-1; Sat, 27 Jun 2020 11:19:07 -0400
X-MC-Unique: guPSaE21MKWlSW1fgjZ1RA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D67851883604;
        Sat, 27 Jun 2020 15:19:05 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED98D60BF4;
        Sat, 27 Jun 2020 15:18:56 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v9 04/11] add ausearch containerid support
Date:   Sat, 27 Jun 2020 11:18:04 -0400
Message-Id: <1593271091-30188-5-git-send-email-rgb@redhat.com>
In-Reply-To: <1593271091-30188-1-git-send-email-rgb@redhat.com>
References: <1593271091-30188-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to ausearch for searching on the containerid field in
records.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 src/aureport-options.c |  1 +
 src/ausearch-llist.c   |  2 ++
 src/ausearch-llist.h   |  1 +
 src/ausearch-match.c   |  3 +++
 src/ausearch-options.c | 48 +++++++++++++++++++++++++++++++++++++++++-
 src/ausearch-options.h |  1 +
 src/ausearch-parse.c   | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/src/aureport-options.c b/src/aureport-options.c
index bd847d7d57f0..29d267f2d1cb 100644
--- a/src/aureport-options.c
+++ b/src/aureport-options.c
@@ -62,6 +62,7 @@ const char *event_vmname = NULL;
 long long event_exit = 0;
 int event_exit_is_set = 0;
 int event_ppid = -1, event_session_id = -2;
+unsigned long long event_contid = -1;
 int event_debug = 0, event_machine = -1;
 
 /* These are used by aureport */
diff --git a/src/ausearch-llist.c b/src/ausearch-llist.c
index ef5503c34fd9..ade727a9e102 100644
--- a/src/ausearch-llist.c
+++ b/src/ausearch-llist.c
@@ -60,6 +60,7 @@ void list_create(llist *l)
 	l->s.arch = 0;
 	l->s.syscall = 0;
 	l->s.session_id = -2;
+	l->s.contid = -1;
 	l->s.uuid = NULL;
 	l->s.vmname = NULL;
 	l->s.tuid = NULL;
@@ -211,6 +212,7 @@ void list_clear(llist* l)
 	l->s.arch = 0;
 	l->s.syscall = 0;
 	l->s.session_id = -2;
+	l->s.contid = -1;
 	free(l->s.uuid);
 	l->s.uuid = NULL;
 	free(l->s.vmname);
diff --git a/src/ausearch-llist.h b/src/ausearch-llist.h
index 64e4ee1f3694..2d1f52237ce6 100644
--- a/src/ausearch-llist.h
+++ b/src/ausearch-llist.h
@@ -56,6 +56,7 @@ typedef struct
   int arch;             // arch
   int syscall;          // syscall
   uint32_t session_id;  // Login session id
+  __u64 contid;         // Container id
   long long exit;       // Syscall exit code
   int exit_is_set;      // Syscall exit code is valid
   char *hostname;       // remote hostname
diff --git a/src/ausearch-match.c b/src/ausearch-match.c
index 61a11d30a09b..47c12581a963 100644
--- a/src/ausearch-match.c
+++ b/src/ausearch-match.c
@@ -113,6 +113,9 @@ int match(llist *l)
 				if ((event_session_id != -2) &&
 					(event_session_id != l->s.session_id))
 					return 0;
+				if ((event_contid != -1) &&
+					(event_contid != l->s.contid))
+					return 0;
 				if (event_exit_is_set) {
 					if (l->s.exit_is_set == 0)
 						return 0;
diff --git a/src/ausearch-options.c b/src/ausearch-options.c
index 5363fdace73c..b45793e88109 100644
--- a/src/ausearch-options.c
+++ b/src/ausearch-options.c
@@ -60,6 +60,7 @@ int event_syscall = -1, event_machine = -1;
 int event_ua = 0, event_ga = 0, event_se = 0;
 int just_one = 0;
 uint32_t event_session_id = -2;
+unsigned long long event_contid = -1;
 long long event_exit = 0;
 int event_exit_is_set = 0;
 int line_buffered = 0;
@@ -92,7 +93,7 @@ S_TIME_END, S_TIME_START, S_TERMINAL, S_ALL_UID, S_EFF_UID, S_UID, S_LOGINID,
 S_VERSION, S_EXACT_MATCH, S_EXECUTABLE, S_CONTEXT, S_SUBJECT, S_OBJECT,
 S_PPID, S_KEY, S_RAW, S_NODE, S_IN_LOGS, S_JUST_ONE, S_SESSION, S_EXIT,
 S_LINEBUFFERED, S_UUID, S_VMNAME, S_DEBUG, S_CHECKPOINT, S_ARCH, S_FORMAT,
-S_EXTRA_TIME, S_EXTRA_LABELS, S_EXTRA_KEYS, S_EXTRA_OBJ2, S_ESCAPE };
+S_EXTRA_TIME, S_EXTRA_LABELS, S_EXTRA_KEYS, S_EXTRA_OBJ2, S_ESCAPE, S_CONTID };
 
 static struct nv_pair optiontab[] = {
 	{ S_EVENT, "-a" },
@@ -100,6 +101,7 @@ static struct nv_pair optiontab[] = {
 	{ S_EVENT, "--event" },
 	{ S_COMM, "-c" },
 	{ S_COMM, "--comm" },
+	{ S_CONTID, "--contid" },
 	{ S_CHECKPOINT, "--checkpoint" },
 	{ S_DEBUG, "--debug" },
 	{ S_EXIT, "-e" },
@@ -197,6 +199,7 @@ static void usage(void)
 	"\t-a,--event <Audit event id>\tsearch based on audit event id\n"
 	"\t--arch <CPU>\t\t\tsearch based on the CPU architecture\n"
 	"\t-c,--comm  <Comm name>\t\tsearch based on command line name\n"
+	"\t--contid <audit container id>\tsearch based on the task's audit container id\n"
 	"\t--checkpoint <checkpoint file>\tsearch from last complete event\n"
 	"\t--debug\t\t\tWrite malformed events that are skipped to stderr\n"
 	"\t-e,--exit  <Exit code or errno>\tsearch based on syscall exit code\n"
@@ -1182,6 +1185,49 @@ int check_params(int count, char *vars[])
 			}
 			c++;
 			break;
+		case S_CONTID:
+			if (!optarg) {
+				if ((c+1 < count) && vars[c+1])
+					optarg = vars[c+1];
+				else {
+					fprintf(stderr,
+						"Argument is required for %s\n",
+						vars[c]);
+					retval = -1;
+					break;
+				}
+			}
+			{
+			size_t len = strlen(optarg);
+
+			if (isdigit(optarg[0])) {
+				errno = 0;
+				event_contid = strtoull(optarg, NULL, 0);
+				if (errno) {
+					fprintf(stderr,
+			"Numeric container ID conversion error (%s) for %s\n",
+						strerror(errno), optarg);
+					retval = -1;
+				}
+			} else if (len >= 2 && *(optarg) == '-' &&
+					(isdigit(optarg[1]))) {
+				errno = 0;
+				event_contid = strtoll(optarg, NULL, 0);
+				if (errno) {
+					retval = -1;
+					fprintf(stderr, "Error converting %s\n",
+						optarg);
+				}
+			} else {
+				fprintf(stderr,
+			"Container ID is non-numeric and unknown (%s)\n",
+						optarg);
+				retval = -1;
+				break;
+			}
+			}
+			c++;
+			break;
 		case S_UUID:
 			if (!optarg) {
 				fprintf(stderr,
diff --git a/src/ausearch-options.h b/src/ausearch-options.h
index 1372762b4b3e..085d492d101c 100644
--- a/src/ausearch-options.h
+++ b/src/ausearch-options.h
@@ -40,6 +40,7 @@ extern int line_buffered;
 extern int event_debug;
 extern pid_t event_ppid;
 extern uint32_t event_session_id;
+extern unsigned long long event_contid;
 extern ilist *event_type;
 
 /* Data type to govern output format */
diff --git a/src/ausearch-parse.c b/src/ausearch-parse.c
index 5cd24e8bd7cb..374b369be7b7 100644
--- a/src/ausearch-parse.c
+++ b/src/ausearch-parse.c
@@ -53,6 +53,8 @@ static int parse_path(const lnode *n, search_items *s);
 static int parse_user(const lnode *n, search_items *s, anode *avc);
 static int parse_obj(const lnode *n, search_items *s);
 static int parse_login(const lnode *n, search_items *s);
+static int parse_container_op(const lnode *n, search_items *s);
+static int parse_container_id(const lnode *n, search_items *s);
 static int parse_daemon1(const lnode *n, search_items *s);
 static int parse_daemon2(const lnode *n, search_items *s);
 static int parse_sockaddr(const lnode *n, search_items *s);
@@ -115,6 +117,9 @@ int extract_search_items(llist *l)
 			case AUDIT_LOGIN:
 				ret = parse_login(n, s);
 				break;
+			case AUDIT_CONTAINER_OP:
+				ret = parse_container_op(n, s);
+				break;
 			case AUDIT_IPC:
 			case AUDIT_OBJ_PID:
 				ret = parse_obj(n, s);
@@ -184,6 +189,9 @@ int extract_search_items(llist *l)
 			case AUDIT_TTY:
 				ret = parse_tty(n, s);
 				break;
+			case AUDIT_CONTAINER_ID:
+				ret = parse_container_id(n, s);
+				break;
 			default:
 				if (event_debug)
 					fprintf(stderr,
@@ -1474,6 +1482,55 @@ static int parse_login(const lnode *n, search_items *s)
 	return 0;
 }
 
+static int parse_container_op(const lnode *n, search_items *s)
+{
+	char *ptr, *str, *term = n->message;
+
+	// skip op
+	// skip opid
+	// get contid
+	if (event_contid != -1) {
+		str = strstr(term, "contid=");
+		if (str == NULL)
+			return 46;
+		ptr = str + 7;
+		term = strchr(ptr, ' ');
+		if (term == NULL)
+			return 47;
+		*term = 0;
+		errno = 0;
+		s->contid = strtoull(ptr, NULL, 10);
+		if (errno)
+			return 48;
+		*term = ' ';
+	}
+	// skip old-contid
+	return 0;
+}
+
+static int parse_container_id(const lnode *n, search_items *s)
+{
+	char *ptr, *str, *term = n->message;
+
+	// get contid
+	if (event_contid != -1) {
+		str = strstr(term, "contid=");
+		if (str == NULL)
+			return 49;
+		ptr = str + 7;
+		term = strchr(ptr, ' ');
+		if (term)
+			return 50;
+		*term = 0;
+		errno = 0;
+		s->contid = strtoull(ptr, NULL, 10);
+		if (errno)
+			return 51;
+		*term = ' ';
+	}
+	return 0;
+}
+
 static int parse_daemon1(const lnode *n, search_items *s)
 {
 	char *ptr, *str, *term, saved, *mptr;
-- 
1.8.3.1

