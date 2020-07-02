Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA89C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A5620780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Lmes5nm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgGBKlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:41:22 -0400
Received: from mail-40137.protonmail.ch ([185.70.40.137]:58625 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgGBKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:41:22 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2020 06:41:19 EDT
Date:   Thu, 02 Jul 2020 10:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1593686006;
        bh=R31tDMfbd3y2g9Es78kyIoLD1EuSIewdA5C0xhoDBmg=;
        h=Date:To:From:Reply-To:Subject:From;
        b=Lmes5nm4XQMkUObjm5dYbm61WQ2XJ7o9Uob75VeTsKY4sLN6ToRaI3yFqRS0nZ5Jn
         gSvUzfhrGkA4zGxKD85mpjEPIeeklzk5hrFvuxVB5VIya6+xpOqA6cPuh8E1DaAcns
         lF5QgprFU2kD8UrrSx6ZHKvYF+La4Vf5wCsEoUV0=
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "neilb@suse.com" <neilb@suse.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   OrToledano <ortoledano@protonmail.com>
Reply-To: OrToledano <ortoledano@protonmail.com>
Subject: [PATCH] list: documentation changes
Message-ID: <OhTdWg9Rr735T1DC2MbKaFXw4RGTTkoZFswh0S8_bLFf66m-6rB9aywTktPQVOttTnX-8n1RDpbnb9JjFLhc7gKgnMOqFiX5m6g_-q_PVLg=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There are & in the documentation for struct pointers, but not for head.
&head in the documentation would be beneficial, since we initialize the
head with LIST_HEAD(name) which creates struct list_head name;
That means in order to pass name to the macros, we need to use &name, and
good documentation can indicate that.

Additionally, I changed "for your list" to "of the list" for consistency
("of the list" occurs more often, and is used exclusively in hashtable.h).

Signed-off-by: Or Toledano <ortoledano@protonmail.com>
---
 include/linux/list.h | 54 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index aff44d34f4e4..5bd7c61d9024 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -76,7 +76,7 @@ static inline void __list_add(struct list_head *new,
 /**
  * list_add - add a new entry
  * @new: new entry to be added
- * @head: list head to add it after
+ * @head: the &head to add it after
  *
  * Insert a new entry after the specified head.
  * This is good for implementing stacks.
@@ -90,7 +90,7 @@ static inline void list_add(struct list_head *new, struct=
 list_head *head)
 /**
  * list_add_tail - add a new entry
  * @new: new entry to be added
- * @head: list head to add it before
+ * @head: the &head to add it before
  *
  * Insert a new entry before the specified head.
  * This is useful for implementing queues.
@@ -208,7 +208,7 @@ static inline void list_del_init(struct list_head *entr=
y)
 /**
  * list_move - delete from one list and add as another's head
  * @list: the entry to move
- * @head: the head that will precede our entry
+ * @head: the &head that will precede our entry
  */
 static inline void list_move(struct list_head *list, struct list_head *hea=
d)
 {
@@ -219,7 +219,7 @@ static inline void list_move(struct list_head *list, st=
ruct list_head *head)
 /**
  * list_move_tail - delete from one list and add as another's tail
  * @list: the entry to move
- * @head: the head that will follow our entry
+ * @head: the &head that will follow our entry
  */
 static inline void list_move_tail(struct list_head *list,
 =09=09=09=09  struct list_head *head)
@@ -230,7 +230,7 @@ static inline void list_move_tail(struct list_head *lis=
t,

 /**
  * list_bulk_move_tail - move a subsection of a list to its tail
- * @head: the head that will follow our entry
+ * @head: the &head that will follow our entry
  * @first: first entry to move
  * @last: last entry to move, can be the same as first
  *
@@ -254,7 +254,7 @@ static inline void list_bulk_move_tail(struct list_head=
 *head,
 /**
  * list_is_first -- tests whether @list is the first entry in list @head
  * @list: the entry to test
- * @head: the head of the list
+ * @head: the &head of the list
  */
 static inline int list_is_first(const struct list_head *list,
 =09=09=09=09=09const struct list_head *head)
@@ -265,7 +265,7 @@ static inline int list_is_first(const struct list_head =
*list,
 /**
  * list_is_last - tests whether @list is the last entry in list @head
  * @list: the entry to test
- * @head: the head of the list
+ * @head: the &head of the list
  */
 static inline int list_is_last(const struct list_head *list,
 =09=09=09=09const struct list_head *head)
@@ -303,7 +303,7 @@ static inline int list_empty_careful(const struct list_=
head *head)

 /**
  * list_rotate_left - rotate the list to the left
- * @head: the head of the list
+ * @head: the &head of the list
  */
 static inline void list_rotate_left(struct list_head *head)
 {
@@ -318,7 +318,7 @@ static inline void list_rotate_left(struct list_head *h=
ead)
 /**
  * list_rotate_to_front() - Rotate list to specific item.
  * @list: The desired new front of the list.
- * @head: The head of the list.
+ * @head: The &head of the list.
  *
  * Rotates list so that @list becomes the new front of the list.
  */
@@ -547,7 +547,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
 /**
  * list_for_each=09-=09iterate over a list
  * @pos:=09the &struct list_head to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  */
 #define list_for_each(pos, head) \
 =09for (pos =3D (head)->next; pos !=3D (head); pos =3D pos->next)
@@ -555,7 +555,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
 /**
  * list_for_each_continue - continue iteration over a list
  * @pos:=09the &struct list_head to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  *
  * Continue to iterate over a list, continuing after the current position.
  */
@@ -565,7 +565,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
 /**
  * list_for_each_prev=09-=09iterate over a list backwards
  * @pos:=09the &struct list_head to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  */
 #define list_for_each_prev(pos, head) \
 =09for (pos =3D (head)->prev; pos !=3D (head); pos =3D pos->prev)
@@ -574,7 +574,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
  * list_for_each_safe - iterate over a list safe against removal of list e=
ntry
  * @pos:=09the &struct list_head to use as a loop cursor.
  * @n:=09=09another &struct list_head to use as temporary storage
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  */
 #define list_for_each_safe(pos, n, head) \
 =09for (pos =3D (head)->next, n =3D pos->next; pos !=3D (head); \
@@ -584,7 +584,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
  * list_for_each_prev_safe - iterate over a list backwards safe against re=
moval of list entry
  * @pos:=09the &struct list_head to use as a loop cursor.
  * @n:=09=09another &struct list_head to use as temporary storage
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  */
 #define list_for_each_prev_safe(pos, n, head) \
 =09for (pos =3D (head)->prev, n =3D pos->prev; \
@@ -594,7 +594,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
 /**
  * list_for_each_entry=09-=09iterate over list of given type
  * @pos:=09the type * to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  */
 #define list_for_each_entry(pos, head, member)=09=09=09=09\
@@ -605,7 +605,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
 /**
  * list_for_each_entry_reverse - iterate backwards over list of given type=
.
  * @pos:=09the type * to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  */
 #define list_for_each_entry_reverse(pos, head, member)=09=09=09\
@@ -616,7 +616,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
 /**
  * list_prepare_entry - prepare a pos entry for use in list_for_each_entry=
_continue()
  * @pos:=09the type * to use as a start point
- * @head:=09the head of the list
+ * @head:=09the &head of the list
  * @member:=09the name of the list_head within the struct.
  *
  * Prepares a pos entry for use as a start point in list_for_each_entry_co=
ntinue().
@@ -627,7 +627,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
 /**
  * list_for_each_entry_continue - continue iteration over list of given ty=
pe
  * @pos:=09the type * to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  *
  * Continue to iterate over list of given type, continuing after
@@ -641,7 +641,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
 /**
  * list_for_each_entry_continue_reverse - iterate backwards from the given=
 point
  * @pos:=09the type * to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  *
  * Start to iterate over list of given type backwards, continuing after
@@ -655,7 +655,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
 /**
  * list_for_each_entry_from - iterate over list of given type from the cur=
rent point
  * @pos:=09the type * to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  *
  * Iterate over list of given type, continuing from current position.
@@ -668,7 +668,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
  * list_for_each_entry_from_reverse - iterate backwards over list of given=
 type
  *                                    from the current point
  * @pos:=09the type * to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  *
  * Iterate backwards over list of given type, continuing from current posi=
tion.
@@ -681,7 +681,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
  * list_for_each_entry_safe - iterate over list of given type safe against=
 removal of list entry
  * @pos:=09the type * to use as a loop cursor.
  * @n:=09=09another type * to use as temporary storage
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  */
 #define list_for_each_entry_safe(pos, n, head, member)=09=09=09\
@@ -694,7 +694,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
  * list_for_each_entry_safe_continue - continue list iteration safe agains=
t removal
  * @pos:=09the type * to use as a loop cursor.
  * @n:=09=09another type * to use as temporary storage
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  *
  * Iterate over list of given type, continuing after current point,
@@ -710,7 +710,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
  * list_for_each_entry_safe_from - iterate over list from current point sa=
fe against removal
  * @pos:=09the type * to use as a loop cursor.
  * @n:=09=09another type * to use as temporary storage
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  *
  * Iterate over list of given type from current point, safe against
@@ -725,7 +725,7 @@ static inline void list_splice_tail_init(struct list_he=
ad *list,
  * list_for_each_entry_safe_reverse - iterate backwards over list safe aga=
inst removal
  * @pos:=09the type * to use as a loop cursor.
  * @n:=09=09another type * to use as temporary storage
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the list_head within the struct.
  *
  * Iterate backwards over list of given type, safe against removal
@@ -959,7 +959,7 @@ static inline void hlist_move_list(struct hlist_head *o=
ld,
 /**
  * hlist_for_each_entry=09- iterate over list of given type
  * @pos:=09the type * to use as a loop cursor.
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the hlist_node within the struct.
  */
 #define hlist_for_each_entry(pos, head, member)=09=09=09=09\
@@ -990,7 +990,7 @@ static inline void hlist_move_list(struct hlist_head *o=
ld,
  * hlist_for_each_entry_safe - iterate over list of given type safe agains=
t removal of list entry
  * @pos:=09the type * to use as a loop cursor.
  * @n:=09=09a &struct hlist_node to use as temporary storage
- * @head:=09the head for your list.
+ * @head:=09the &head of the list.
  * @member:=09the name of the hlist_node within the struct.
  */
 #define hlist_for_each_entry_safe(pos, n, head, member) =09=09\
--
2.26.2

