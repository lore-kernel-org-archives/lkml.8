Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9D0C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE37206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PE8pXvAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgA3Mmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:42:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35806 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3Mmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:42:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130124251euoutp01abb9a79cd4060b990c5418b8feff2e1a~uqqs1nufd2932129321euoutp01q
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:42:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130124251euoutp01abb9a79cd4060b990c5418b8feff2e1a~uqqs1nufd2932129321euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580388171;
        bh=C2/gDuPh/YjMrhIA5Fi5BfCbgFyvnjBPSfOWNOLrtLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PE8pXvAil21HQuednyUO9bmhdHb0GlV1xrwy+1cJt7cIovJM2icUesFn/z6ZSP+Hz
         nVm5AuNIz4ZSC9BVmRuAFzvRIySQUr4eJLMW6bAj+XRq96CH19WHwc2oTA8dc7n7N9
         9wUD8nPtZws2ujhocRsutypBnBbbLvxEpJTh4n/c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130124251eucas1p1278a6ff8d17ec92d81d324786b6049ca~uqqsorbC-0694706947eucas1p1m;
        Thu, 30 Jan 2020 12:42:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E3.DF.60679.B4FC23E5; Thu, 30
        Jan 2020 12:42:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130124251eucas1p2046004a71a1a9ff4274a6d1d96e2c260~uqqsUzrLQ1244712447eucas1p25;
        Thu, 30 Jan 2020 12:42:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130124251eusmtrp105ee7c9b42a2afb3b7c4060ce748b448~uqqsUPuTd2256122561eusmtrp1H;
        Thu, 30 Jan 2020 12:42:51 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-e7-5e32cf4b00af
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.2E.08375.A4FC23E5; Thu, 30
        Jan 2020 12:42:50 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200130124250eusmtip261dbfe54d9ddf3a6aa884504c66b3de0~uqqsHrrF81635516355eusmtip2J;
        Thu, 30 Jan 2020 12:42:50 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [RFC PATCH 1/4] scripts/dtc: update fdtget.c to upstream version
 v1.4.7-57-gf267e674d145
Date:   Thu, 30 Jan 2020 13:42:30 +0100
Message-Id: <20200130124233.4006-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130123934.3900-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzneV3v80ZxBjuPC1vcPLSC0WLT42us
        Fpd3zWGzmHF+H5MDi8fmJfUefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlfGw9y5bwWHXijdn
        25kbGA+bdTFyckgImEg8ePiHvYuRi0NIYAWjxNW+3YwQzhdGifmTlzOCVAkJfGaUmHgxCaZj
        5p2HLBBFyxkl9v/fA9X+nFFi5b9+JpAqNgFHif6lJ1hBbBGBbInJH7+AxZkF7CUmzvrPBmIL
        CyRLbG2fBFbDIqAq8WhFE1icV8BKovFeFxvENnmJ873r2EFsTgFriUNTFrJA1AhKnJz5BMzm
        F9CSWNN0nQVivrxE89bZzCAHSQi0s0ucbOqHGuQisWlLOxOELSzx6vgWdghbRuL05B6gZg4g
        u15i8iQziN4eRoltc36wQNRYS9w594sNpIZZQFNi/S59iLCjxJX2djaIVj6JG28FIU7gk5i0
        bTozRJhXoqNNCKJaRWJd/x6ogVISva9WME5gVJqF5JlZSB6YhbBrASPzKkbx1NLi3PTUYqO8
        1HK94sTc4tK8dL3k/NxNjMCkcfrf8S87GHf9STrEKMDBqMTD63HGKE6INbGsuDL3EKMEB7OS
        CK+oq2GcEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYyb
        65bnKjE5+tRNWSVrHTKt+af3Hqabk/s55lxZsF175snkR9FfQ0VeHA656m9RxunJuf3X1abE
        67MO1Qbf7Eh3c/3mUq5tv7brkTLP22/32usMaxuvHV96Sf9ERVB5m39q7ms/vRN1M36uubp0
        x6RF+VXnNO02/vv5KmZximCVQeCJ99MW+39TYinOSDTUYi4qTgQA06wDwxYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xe7pe543iDDb+sbC4eWgFo8Wmx9dY
        LS7vmsNmMeP8PiYHFo/NS+o9+rasYvT4vEkugDlKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
        xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Nh7122gsOuFW/OtjM3MB4262Lk5JAQMJGYeech
        SxcjF4eQwFJGifW7frB1MXIAJaQkVs5Nh6gRlvhzrYsNouYpo8SkW2vZQRJsAo4S/UtPsILY
        IgK5EtcOHQWLMwvYS0yc9Z8NxBYWSJSYdvwWE4jNIqAq8WhFE1icV8BKovFeFxvEAnmJ873r
        wHo5BawlDk1ZyAJygxBQzevd6hDlghInZz4BCzMLqEusnycEEuYX0JJY03SdBWKrvETz1tnM
        ExiFZiHpmIXQMQtJ1QJG5lWMIqmlxbnpucWGesWJucWleel6yfm5mxiBEbLt2M/NOxgvbQw+
        xCjAwajEw+txxihOiDWxrLgy9xCjBAezkgivqKthnBBvSmJlVWpRfnxRaU5q8SFGU6AvJzJL
        iSbnA6M3ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo8//xKnR
        YTVT8oVq87+cv8MddO/tZcMetfDIPu0tLVOWV/zRFlq+k+Nric9WjiCBrunvq/bMD7+j8/D5
        7PM/Fz+Nlv7N/fLJJuuf4moK3dNFm4LDGH/dDvm0ltPio+D/880cim7rvnydzPd+m7Vtx1KZ
        J5NkGa72i5uqCPefZJ04JWqrnOb8KiWW4oxEQy3mouJEAKKrU/ymAgAA
X-CMS-MailID: 20200130124251eucas1p2046004a71a1a9ff4274a6d1d96e2c260
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200130124251eucas1p2046004a71a1a9ff4274a6d1d96e2c260
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200130124251eucas1p2046004a71a1a9ff4274a6d1d96e2c260
References: <20200130123934.3900-1-l.stelmach@samsung.com>
        <CGME20200130124251eucas1p2046004a71a1a9ff4274a6d1d96e2c260@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build and fdtget and add fdtget.c to the list of update source files.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 scripts/dtc/.gitignore           |   4 +
 scripts/dtc/Makefile             |   5 ++
 scripts/dtc/fdtget.c             | 125 ++++++++++++++++++-------------
 scripts/dtc/update-dtc-source.sh |   4 +-
 4 files changed, 82 insertions(+), 56 deletions(-)

diff --git scripts/dtc/.gitignore scripts/dtc/.gitignore
index 2e6e60d64ede..80f6b50fdf77 100644
--- scripts/dtc/.gitignore
+++ scripts/dtc/.gitignore
@@ -1 +1,5 @@
 dtc
+dtc-lexer.lex.c
+dtc-parser.tab.c
+dtc-parser.tab.h
+fdtget
diff --git scripts/dtc/Makefile scripts/dtc/Makefile
index b5a5b1c548c9..74322d8dac25 100644
--- scripts/dtc/Makefile
+++ scripts/dtc/Makefile
@@ -2,12 +2,15 @@
 # scripts/dtc makefile
 
 hostprogs-$(CONFIG_DTC) := dtc
+hostprogs-$(CONFIG_DTC) += fdtget
 always		:= $(hostprogs-y)
 
 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 		   srcpos.o checks.o util.o
 dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
+fdtget-objs     := fdtget.o util.o
+
 # Source files need to get at the userspace version of libfdt_env.h to compile
 HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
 
@@ -26,5 +29,7 @@ endif
 HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
 HOSTCFLAGS_dtc-parser.tab.o := -I $(srctree)/$(src)
 
+HOSTLDLIBS_fdtget := -L$(obj)/libfdt -lfdt -Wl,-rpath='$$ORIGIN/libfdt'
+
 # dependencies on generated files need to be listed explicitly
 $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
diff --git scripts/dtc/fdtget.c scripts/dtc/fdtget.c
index c922f82246c6..777582e2d45f 100644
--- scripts/dtc/fdtget.c
+++ scripts/dtc/fdtget.c
@@ -39,6 +39,37 @@ static void report_error(const char *where, int err)
 	fprintf(stderr, "Error at '%s': %s\n", where, fdt_strerror(err));
 }
 
+/**
+ * Shows a list of cells in the requested format
+ *
+ * @param disp		Display information / options
+ * @param data		Data to display
+ * @param len		Maximum length of buffer
+ * @param size		Data size to use for display (e.g. 4 for 32-bit)
+ * @return 0 if ok, -1 on error
+ */
+static int show_cell_list(struct display_info *disp, const char *data, int len,
+			  int size)
+{
+	const uint8_t *p = (const uint8_t *)data;
+	char fmt[3];
+	int value;
+	int i;
+
+	fmt[0] = '%';
+	fmt[1] = disp->type ? disp->type : 'd';
+	fmt[2] = '\0';
+	for (i = 0; i < len; i += size, p += size) {
+		if (i)
+			printf(" ");
+		value = size == 4 ? fdt32_ld((const fdt32_t *)p) :
+			size == 2 ? (*p << 8) | p[1] : *p;
+		printf(fmt, value);
+	}
+
+	return 0;
+}
+
 /**
  * Displays data of a given length according to selected options
  *
@@ -52,12 +83,9 @@ static void report_error(const char *where, int err)
  */
 static int show_data(struct display_info *disp, const char *data, int len)
 {
-	int i, size;
-	const uint8_t *p = (const uint8_t *)data;
+	int size;
 	const char *s;
-	int value;
 	int is_string;
-	char fmt[3];
 
 	/* no data, don't print */
 	if (len == 0)
@@ -85,17 +113,8 @@ static int show_data(struct display_info *disp, const char *data, int len)
 				"selected data size\n");
 		return -1;
 	}
-	fmt[0] = '%';
-	fmt[1] = disp->type ? disp->type : 'd';
-	fmt[2] = '\0';
-	for (i = 0; i < len; i += size, p += size) {
-		if (i)
-			printf(" ");
-		value = size == 4 ? fdt32_to_cpu(*(const uint32_t *)p) :
-			size == 2 ? (*p << 8) | p[1] : *p;
-		printf(fmt, value);
-	}
-	return 0;
+
+	return show_cell_list(disp, data, len, size);
 }
 
 /**
@@ -107,7 +126,6 @@ static int show_data(struct display_info *disp, const char *data, int len)
  */
 static int list_properties(const void *blob, int node)
 {
-	const struct fdt_property *data;
 	const char *name;
 	int prop;
 
@@ -116,8 +134,7 @@ static int list_properties(const void *blob, int node)
 		/* Stop silently when there are no more properties */
 		if (prop < 0)
 			return prop == -FDT_ERR_NOTFOUND ? 0 : prop;
-		data = fdt_get_property_by_offset(blob, prop, NULL);
-		name = fdt_string(blob, fdt32_to_cpu(data->nameoff));
+		fdt_getprop_by_offset(blob, prop, &name, NULL);
 		if (name)
 			puts(name);
 		prop = fdt_next_property_offset(blob, prop);
@@ -231,7 +248,7 @@ static int show_data_for_item(const void *blob, struct display_info *disp,
  * @param filename	Filename of blob file
  * @param arg		List of arguments to process
  * @param arg_count	Number of arguments
- * @param return 0 if ok, -ve on error
+ * @return 0 if ok, -ve on error
  */
 static int do_fdtget(struct display_info *disp, const char *filename,
 		     char **arg, int arg_count, int args_per_step)
@@ -240,7 +257,7 @@ static int do_fdtget(struct display_info *disp, const char *filename,
 	const char *prop;
 	int i, node;
 
-	blob = utilfdt_read(filename);
+	blob = utilfdt_read(filename, NULL);
 	if (!blob)
 		return -1;
 
@@ -252,44 +269,50 @@ static int do_fdtget(struct display_info *disp, const char *filename,
 				continue;
 			} else {
 				report_error(arg[i], node);
+				free(blob);
 				return -1;
 			}
 		}
 		prop = args_per_step == 1 ? NULL : arg[i + 1];
 
-		if (show_data_for_item(blob, disp, node, prop))
+		if (show_data_for_item(blob, disp, node, prop)) {
+			free(blob);
 			return -1;
+		}
 	}
+
+	free(blob);
+
 	return 0;
 }
 
-static const char *usage_msg =
-	"fdtget - read values from device tree\n"
-	"\n"
-	"Each value is printed on a new line.\n\n"
-	"Usage:\n"
+/* Usage related data. */
+static const char usage_synopsis[] =
+	"read values from device tree\n"
 	"	fdtget <options> <dt file> [<node> <property>]...\n"
 	"	fdtget -p <options> <dt file> [<node> ]...\n"
-	"Options:\n"
-	"\t-t <type>\tType of data\n"
-	"\t-p\t\tList properties for each node\n"
-	"\t-l\t\tList subnodes for each node\n"
-	"\t-d\t\tDefault value to display when the property is "
-			"missing\n"
-	"\t-h\t\tPrint this help\n\n"
+	"\n"
+	"Each value is printed on a new line.\n"
 	USAGE_TYPE_MSG;
-
-static void usage(const char *msg)
-{
-	if (msg)
-		fprintf(stderr, "Error: %s\n\n", msg);
-
-	fprintf(stderr, "%s", usage_msg);
-	exit(2);
-}
+static const char usage_short_opts[] = "t:pld:" USAGE_COMMON_SHORT_OPTS;
+static struct option const usage_long_opts[] = {
+	{"type",              a_argument, NULL, 't'},
+	{"properties",       no_argument, NULL, 'p'},
+	{"list",             no_argument, NULL, 'l'},
+	{"default",           a_argument, NULL, 'd'},
+	USAGE_COMMON_LONG_OPTS,
+};
+static const char * const usage_opts_help[] = {
+	"Type of data",
+	"List properties for each node",
+	"List subnodes for each node",
+	"Default value to display when the property is missing",
+	USAGE_COMMON_OPTS_HELP
+};
 
 int main(int argc, char *argv[])
 {
+	int opt;
 	char *filename = NULL;
 	struct display_info disp;
 	int args_per_step = 2;
@@ -298,20 +321,14 @@ int main(int argc, char *argv[])
 	memset(&disp, '\0', sizeof(disp));
 	disp.size = -1;
 	disp.mode = MODE_SHOW_VALUE;
-	for (;;) {
-		int c = getopt(argc, argv, "d:hlpt:");
-		if (c == -1)
-			break;
-
-		switch (c) {
-		case 'h':
-		case '?':
-			usage(NULL);
+	while ((opt = util_getopt_long()) != EOF) {
+		switch (opt) {
+		case_USAGE_COMMON_FLAGS
 
 		case 't':
 			if (utilfdt_decode_type(optarg, &disp.type,
 					&disp.size))
-				usage("Invalid type string");
+				usage("invalid type string");
 			break;
 
 		case 'p':
@@ -333,7 +350,7 @@ int main(int argc, char *argv[])
 	if (optind < argc)
 		filename = argv[optind++];
 	if (!filename)
-		usage("Missing filename");
+		usage("missing filename");
 
 	argv += optind;
 	argc -= optind;
@@ -344,7 +361,7 @@ int main(int argc, char *argv[])
 
 	/* Check for node, property arguments */
 	if (args_per_step == 2 && (argc % 2))
-		usage("Must have an even number of arguments");
+		usage("must have an even number of arguments");
 
 	if (do_fdtget(&disp, filename, argv, argc, args_per_step))
 		return 1;
diff --git scripts/dtc/update-dtc-source.sh scripts/dtc/update-dtc-source.sh
index 7dd29a0362b8..8db277546785 100755
--- scripts/dtc/update-dtc-source.sh
+++ scripts/dtc/update-dtc-source.sh
@@ -31,8 +31,8 @@ set -ev
 DTC_UPSTREAM_PATH=`pwd`/../dtc
 DTC_LINUX_PATH=`pwd`/scripts/dtc
 
-DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
-		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c Makefile.dtc \
+DTC_SOURCE="checks.c data.c dtc.c dtc.h fdtget.c flattree.c fstree.c livetree.c
+		srcpos.c srcpos.h treesource.c util.c util.h version_gen.h Makefile.dtc \
 		dtc-lexer.l dtc-parser.y"
 LIBFDT_SOURCE="Makefile.libfdt fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
-- 
2.20.1

